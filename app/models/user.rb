class User < ApplicationRecord

  validates :name, presence: true
  # constant variable
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: true
  has_secure_password
  validates :password, presence: true, allow_nil: true
  validates :picture, file_size: { less_than_or_equal_to: 500.kilobytes },
                   file_content_type: { allow: ['image/jpeg', 'image/png'] }
  mount_uploader :picture, PictureUploader

  has_many :activites

  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def followers
    Relationship.where(followed_id: id)
  end

  def following
    Relationship.where(follower_id: id)
  end

  def relationship(other_user)
    Relationship.find_by(
      follower_id: id,
      followed_id: other_user.id
      )
  end

end

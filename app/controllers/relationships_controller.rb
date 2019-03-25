class RelationshipsController < ApplicationController
  def create

    relationship = Relationship.new(
      follower_id: current_user.id,
      followed_id: params[:followed_id]
      )
    relationship.save

    Activity.create(user_id: current_user.id, action_id: relationship.id, action_type: "Relationship")

    redirect_to user_url(params[:followed_id])
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy

    redirect_to user_url(relationship.followed_id)
  end
end

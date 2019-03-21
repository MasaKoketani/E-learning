class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.references :question
      t.string :content
      t.boolean :correct, default: false, null: false

      t.timestamps
    end
  end
end

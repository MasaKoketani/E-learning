class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user
      t.integer :action_id
      t.text :action_type

      t.timestamps
    end
  end
end

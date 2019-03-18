class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.references :question
      t.string :content
      t.boolean :corrent

      t.timestamps
    end
  end
end

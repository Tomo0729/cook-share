class CreateTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_relations do |t|
      t.integer :recipe_id
      t.integer :tag_id
      t.timestamps
    end
  end
end

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.text :introduction
      t.string :image
      t.timestamps
    end
  end
end

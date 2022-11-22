class CreateCookSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :cook_steps do |t|
      t.integer :recipe_id
      t.text :direction
      t.string :image
      t.timestamps
    end
  end
end

class CreateSavedRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :saved_recipes do |t|
      t.references :user,   null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end

    add_index :saved_recipes, [:user_id, :recipe_id], unique: true
  end
end

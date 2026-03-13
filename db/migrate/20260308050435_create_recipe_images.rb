class CreateRecipeImages < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_images do |t|
      t.references :recipe,   null: false, foreign_key: true
      t.string     :image,    null: false
      t.integer    :position, default: 0

      t.timestamps
    end
  end
end

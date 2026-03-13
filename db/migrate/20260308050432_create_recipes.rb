class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.references :user,          null: false, foreign_key: true
      t.string     :title,         null: false
      t.text       :description
      t.integer    :base_servings, null: false, default: 1
      t.integer    :prep_time_mins
      t.integer    :cook_time_mins
      t.string     :cover_image
      t.integer    :status,        null: false, default: 0

      t.timestamps
    end

    add_index :recipes, [:user_id, :created_at]
  end
end

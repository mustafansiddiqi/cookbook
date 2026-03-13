class CreateIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe,   null: false, foreign_key: true
      t.string     :name,     null: false
      t.decimal    :amount,   precision: 8, scale: 3, null: false
      t.integer    :unit,     null: false, default: 0
      t.integer    :position, default: 0

      t.timestamps
    end
  end
end

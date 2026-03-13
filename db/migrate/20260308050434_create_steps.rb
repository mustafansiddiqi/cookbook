class CreateSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :steps do |t|
      t.references :recipe,      null: false, foreign_key: true
      t.integer    :position,    null: false, default: 0
      t.text       :instruction, null: false
      t.string     :image

      t.timestamps
    end
  end
end

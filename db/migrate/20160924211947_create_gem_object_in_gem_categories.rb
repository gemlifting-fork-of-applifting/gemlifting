class CreateGemObjectInGemCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :gem_object_in_gem_categories do |t|
      t.references :gem_object, foreign_key: true
      t.references :gem_category, foreign_key: true

      t.timestamps
    end

    add_index :gem_object_in_gem_categories, [:gem_object_id, :gem_category_id], unique: true, name: 'index_gem_in_gem_categories_on_gem_id_and_gem_category_id'
  end
end
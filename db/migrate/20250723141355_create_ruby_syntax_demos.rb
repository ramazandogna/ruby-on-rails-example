class CreateRubySyntaxDemos < ActiveRecord::Migration[8.0]
  def change
    create_table :ruby_syntax_demos do |t|
      t.string :title
      t.text :content
      t.string :category
      t.boolean :published

      t.timestamps
    end
  end
end

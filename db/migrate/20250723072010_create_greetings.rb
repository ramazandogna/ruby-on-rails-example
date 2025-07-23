class CreateGreetings < ActiveRecord::Migration[8.0]
  def change
    create_table :greetings do |t|
      t.string :message
      t.string :language

      t.timestamps
    end
  end
end

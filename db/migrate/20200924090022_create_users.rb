class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :sub
      t.string :name
      t.string :introduction

      t.timestamps
    end
  end
end
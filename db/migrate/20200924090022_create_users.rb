class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :string do |t|
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :profileImageUrl, null: false, default: ''

      t.timestamps
    end
  end
end

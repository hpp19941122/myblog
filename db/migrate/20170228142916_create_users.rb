class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string       :username,      null: false,  limit: 32
      t.string       :password,       null: false,  limit: 64
      t.string       :nickname,       null: false,  limit: 32
      t.boolean    :enable,           null: false,  default: true
      t.timestamps                      null: false
    end
  end
end
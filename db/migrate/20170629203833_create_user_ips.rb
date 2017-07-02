class CreateUserIps < ActiveRecord::Migration[5.1]
  def change
    create_table :user_ips do |t|
      t.inet        :user_ip, null: false
      t.references  :user,    null: false, foreign_key: true, index: true
    end

    add_index(:user_ips, [:user_ip, :user_id], unique: true)
  end
end

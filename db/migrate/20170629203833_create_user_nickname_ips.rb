class CreateUserNicknameIps < ActiveRecord::Migration[5.1]
  def change
    create_table :user_nickname_ips do |t|
      t.inet   :user_ip,  null: false
      t.string :nickname, null: false
    end

    add_index(:user_nickname_ips, [:user_ip, :nickname], unique: true)
  end
end

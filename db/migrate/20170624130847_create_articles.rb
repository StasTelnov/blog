class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string      :title,           null: false
      t.text        :content,         null: false
      t.inet        :user_ip,         null: false
      t.float       :average_rating,  null: false, default: 0.0
      t.references  :user,            null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end

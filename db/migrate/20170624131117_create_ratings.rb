class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer     :value,   null: false
      t.references  :article, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end

class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      10.times do |i|
        t.string "col#{i}"
      end
      t.timestamps null: false
    end
  end
end

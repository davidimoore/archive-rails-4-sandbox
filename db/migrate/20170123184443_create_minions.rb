class CreateMinions < ActiveRecord::Migration
  def change
    create_table :minions do |t|
      t.references :thing
      t.references :user, foreign_key: true
      10.times do |i|
        t.string "mcol#{i}"
      end
      t.timestamps null: false
    end
  end
end

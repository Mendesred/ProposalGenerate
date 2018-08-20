class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.string :periodo

      t.timestamps null: false
    end
  end
end

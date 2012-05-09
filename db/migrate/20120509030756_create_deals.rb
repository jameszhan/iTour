class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :url
      t.text :intro
      t.decimal :price, :precision => 6, :scale => 2
      t.string :type
      t.string :provider

      t.timestamps
    end
    add_index :deals, :url
  end
end

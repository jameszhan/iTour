class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :url
      t.text :intro
      t.decimal :price, :precision => 6, :scale => 2 
      t.string :image
      t.string :catalog
      t.string :provider

      t.timestamps
    end
    add_index :deals, :url
  end
end

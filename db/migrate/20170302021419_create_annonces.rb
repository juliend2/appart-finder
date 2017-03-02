class CreateAnnonces < ActiveRecord::Migration
  def change
    create_table :annonces do |t|
      t.string :url, null: false
      t.string :state, default: 'unjudged'
      t.string :title
      t.float :price
      t.float :longitude
      t.float :latitude
    end
    add_index :annonces, :url, unique: true
  end
end

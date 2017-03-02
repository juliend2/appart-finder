class AddPlaceToAnnonces < ActiveRecord::Migration
  def change
    add_column :annonces, :place, :string
  end
end

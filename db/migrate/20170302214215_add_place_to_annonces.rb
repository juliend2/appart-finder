class AddPlaceToAnnonces < ActiveRecord::Migration[4.2]
  def change
    add_column :annonces, :place, :string
  end
end

class AddFieldsToAnnonces < ActiveRecord::Migration[4.2]
  def change
    add_column :annonces, :date_posted, :date
  end
end

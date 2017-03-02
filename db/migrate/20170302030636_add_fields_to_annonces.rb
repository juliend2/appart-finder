class AddFieldsToAnnonces < ActiveRecord::Migration
  def change
    add_column :annonces, :date_posted, :date
  end
end

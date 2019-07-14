class AddApprovedToInstitutions < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :approved, :boolean, default: true
  end
end

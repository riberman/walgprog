class AddImageToResearchers < ActiveRecord::Migration[5.2]
  def change
    add_column :researchers, :image, :string
  end
end

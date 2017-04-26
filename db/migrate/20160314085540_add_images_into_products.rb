class AddImagesIntoProducts < ActiveRecord::Migration
  def change
    add_column :products, :banner, :string
    add_column :products, :listing, :string
    add_column :products, :side, :string
  end
end

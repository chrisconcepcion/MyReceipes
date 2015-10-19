class CreateChefs < ActiveRecord::Migration
  def change
    create_table :chefs do |t|
      t.string :email
      t.string :chefname
      t.timestamps
    end
  end
end

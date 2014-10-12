class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :uid
      t.string :parent
      t.string :text
      t.string :range
    end
  end
end

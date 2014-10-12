class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :uid
      t.string :parent
      t.string :text
      t.string :range

      t.timestamps
    end
  end
end

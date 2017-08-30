class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :base_url
      t.datetime :last_visted, default: DateTime.now
      t.timestamps
    end
  end
end

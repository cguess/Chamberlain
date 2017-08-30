class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|

    	t.string :uuid, index: true, unique: true

    	# Custom name
    	t.string :name
    	# Description for admin's to know what it's supposed to do
    	t.string :description
    	# API key for authentication
    	t.string :api_key, unique: true

    	t.integer :facts_count, default: 0
    	t.datetime :last_seen, default: DateTime.now
    	t.timestamps
    end
  end
end

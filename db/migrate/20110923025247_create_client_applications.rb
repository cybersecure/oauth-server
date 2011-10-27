class CreateClientApplications < ActiveRecord::Migration
  def change
    create_table :client_applications do |t|
      t.string :client_id
      t.string :client_secret
      t.string :client_url
      t.string :description
      t.string :logo_url
      t.string :client_name
      
      t.timestamps
    end
  end
end

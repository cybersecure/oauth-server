class CreateClientApplications < ActiveRecord::Migration
  def change
    create_table :client_applications do |t|
      t.string :app_id
      t.string :app_secret
      t.string :app_url

      t.timestamps
    end
  end
end

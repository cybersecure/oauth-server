class CreateAuthorizationRequests < ActiveRecord::Migration
  def change
    create_table :authorization_requests do |t|
      t.string :response_type
      t.integer :client_application_id
      t.string :scope
      t.string :redirect_uri
      t.string :state
      t.string :code

      t.timestamps
    end
  end
end

class CreateAuthorizationRequests < ActiveRecord::Migration
  def change
    create_table :authorization_requests do |t|
      t.string :response_type
      t.string :client_application_id
      t.string :redirect_uri
      t.string :scope
      t.string :state
      t.string :code
      t.datetime :expire_at

      t.timestamps
    end
  end
end

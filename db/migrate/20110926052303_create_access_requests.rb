class CreateAccessRequests < ActiveRecord::Migration
  def change
    create_table :access_requests do |t|
      t.integer :authorization_request_id
      t.string :grant_type
      t.string :redirect_uri
      t.string :access_token
      t.string :token_type
      t.integer :expires_in
      t.string :state
      t.string :refresh_token

      t.timestamps
    end
  end
end

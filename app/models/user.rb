class User < ActiveRecord::Base
  include HashModule
  has_secure_password

  attr_accessible :username, :email, :password, :password_confirmation, :language
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :username
  validates_uniqueness_of :username

  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      self[column] = HashModule::SecureToken.generate_token
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
end

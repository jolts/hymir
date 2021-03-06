class User
  include MongoMapper::Document
  include Hymir::Gravatar

  key :username, String, :required => true, :unique => true
  key :email, String, :required => true, :unique => true
  key :crypted_password, String
  key :reset_password_code, String
  key :reset_password_code_until, Time
  timestamps!

  has_many :posts
  has_many :pages

  RegEmailOk = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i

  validates_length_of :username, :within => 2..32
  validates_length_of :email, :within => 6..100
  validates_format_of :email, :with => RegEmailOk
  validates_presence_of :password
  validates_length_of :password, :minimum => 6
  validates_confirmation_of :password

  def to_param
    username
  end

  def self.authenticate(email_or_username, secret)
    u = find_by_email(email_or_username.downcase) || find_by_username(email_or_username)
    u && u.authenticated?(secret) ? u : nil
  end

  def authenticated?(secret)
    password == secret
  end

  def password
    @password ||= BCrypt::Password.new(crypted_password) if crypted_password.present?
  end

  def password=(value)
    @password = value
    write_attribute(:crypted_password, BCrypt::Password.create(value))
  end

  def email=(given_email)
    write_attribute(:email, given_email.downcase)
  end

  def set_password_code!
    seed = "#{email}#{Time.now.to_s.split(//).sort_by {rand}.join}"
    write_attribute(:reset_password_code_until, 1.day.from_now)
    write_attribute(:reset_password_code, Digest::SHA1.hexdigest(seed))
    save(:validate => false)
  end
end

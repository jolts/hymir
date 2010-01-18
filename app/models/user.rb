class User
  include MongoMapper::Document
  include Gravatarable

  key :username, String, :required => true, :unique => true
  key :email, String, :required => true, :unique => true
  key :crypted_password, String
  key :roles_mask, Integer, :numeric => true
  # 4: Author
  # 2: Moderator
  # 1: Admin
  key :reset_password_code, String
  key :reset_password_code_until, Time
  timestamps!

  has_many :posts

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

  Roles = %w[admin moderator author]

  def roles=(roles)
    write_attribute(:roles_mask, (roles & Roles).map {|r| 2**Roles.index(r)}.sum)
  end

  def roles
    Roles.reject {|r| ((roles_mask || 0) & 2**Roles.index(r)).zero?}
  end

  def role?(role)
    roles.include? role.to_s
  end

  def set_password_code!
    seed = "#{email}#{Time.now.to_s.split(//).sort_by {rand}.join}"
    self.reset_password_code_until = 1.day.from_now
    self.reset_password_code = Digest::SHA1.hexdigest(seed)
    save
  end
end

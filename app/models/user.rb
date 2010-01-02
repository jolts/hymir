require 'digest/sha1'
class User
  include MongoMapper::Document

  key :username, String, :required => true, :unique => true
  key :email, String, :required => true, :unique => true
  key :crypted_password, String
  key :roles_mask, Integer
  # 4: Author
  # 2: Moderator
  # 1: Admin
  timestamps!

  many :posts

  RegEmailName = '[\w\.%\+\-]+'
  RegDomainHead = '(?:[A-Z0-9\-]+\.)+'
  RegDomainTLD = '(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  RegEmailOk = /\A#{RegEmailName}@#{RegDomainHead}#{RegDomainTLD}\z/i

  validates_length_of :username, :within => 2..32
  validates_length_of :email, :within => 6..100
  validates_format_of :email, :with => RegEmailOk
  validates_presence_of :password
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6

  def self.authenticate(email, secret)
    u = User.find_by_email(email.downcase)
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
end

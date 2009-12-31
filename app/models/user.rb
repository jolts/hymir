require 'digest/sha1'
class User
  include MongoMapper::Document

  key :username, String, :required => true, :unique => true
  key :email, String, :required => true, :unique => true
  key :crypted_password, String

  many :posts

  RegEmailName = '[\w\.%\+\-]+'
  RegDomainHead = '(?:[A-Z0-9\-]+\.)+'
  RegDomainTLD = '(?:[A-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)'
  RegEmailOk = /\A#{RegEmailName}@#{RegDomainHead}#{RegDomainTLD}\z/i

  def self.authenticate(email, secret)
    u = User.first(:conditions => {:email => email.downcase})
    u && u.authenticated?(secret) ? u : nil
  end

  validates_length_of :username, :within => 2..32
  validates_length_of :email, :within => 6..100
  validates_format_of :email, :with => RegEmailOk
  validates_presence_of :password
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6

  def authenticated?(secret)
    password == secret
  end

  def password
    if crypted_password.present?
      @password ||= BCrypt::Password.new(crypted_password)
    else
      nil
    end
  end

  def password=(value)
    if value.present?
      @password = value
      self.crypted_password = BCrypt::Password.create(value)
    end
  end

  def email=(new_email)
    new_email.downcase! unless new_email.nil?
    write_attribute(:email, new_email)
  end
end

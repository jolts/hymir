class Comment
  include MongoMapper::EmbeddedDocument

  key :name, String, :required => true, :allow_blank => false
  key :email, String, :required => true, :allow_blank => false
  key :website, String
  key :body, String, :required => true, :allow_blank => false
  key :created_at, Time

  validates_length_of :name, :within => 2..32
  validates_length_of :email, :within => 6..100
  validates_format_of :email, :with => User::RegEmailOk
end

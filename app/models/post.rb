class Post
  include MongoMapper::Document

  key :user_id, ObjectId
  key :title, String, :required => true, :allow_blank => false, :unique => true
  key :body, String, :required => true, :allow_blank => false
  key :created_at, DateTime
  key :updated_at, DateTime

  validates_length_of :title, :within => 4..40

  #many :comments
  belongs_to :user
end

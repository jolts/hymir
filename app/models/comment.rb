class Comment
  include MongoMapper::Document

  key :user_id, ObjectId
  key :post_id, ObjectId
  key :body, String, :required => true, :allow_blank => false
  key :created_at, Time
  key :updated_at, Time

  belongs_to :post
  belongs_to :user
end

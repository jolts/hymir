class Page
  include MongoMapper::Document

  key :user_id, ObjectId
  key :title, String, :required => true, :allow_blank => false, :unique => true
  key :url, String, :required => true, :allow_blank => false, :unique => true
  key :body, String, :required => true, :allow_blank => false
  timestamps!
  userstamps!

  belongs_to :user

  RegUrlOk = /\A[a-z]+\z/

  validates_length_of :title, :within => 4..40
  validates_length_of :url, :within => 3..12
  validates_format_of :url, :with => RegUrlOk

  def to_param
    url
  end

  def updated?
    updated_at > created_at
  end
end

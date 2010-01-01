class Post
  include MongoMapper::Document

  before_create :make_slug

  key :user_id, ObjectId
  key :title, String, :required => true, :allow_blank => false, :unique => true
  key :body, String, :required => true, :allow_blank => false
  key :slug, String, :unique => true
  key :tags, Array
  key :created_at, Time
  key :updated_at, Time

  validates_length_of :title, :within => 4..40
  # TODO: Validate tag format (tag1; tag2; tag3; etc)

  many :comments, :dependent => :destroy
  belongs_to :user

  def url
    t = self.created_at
    "/posts/#{t.year}/#{t.month}/#{t.day}/#{self.slug}"
  end

  def named_tags=(given_tags)
    self.tags = given_tags.split(/;\s*/).map {|t| t.downcase}
  end

  def named_tags
    self.tags.join('; ')
  end

  private
    def make_slug
      self.slug = self.title.downcase.gsub(/ /, '-').gsub(/[^a-z0-9-]/, '').squeeze('-')
    end
  # private
end

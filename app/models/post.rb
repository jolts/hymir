class Post
  include MongoMapper::Document

  key :user_id, ObjectId
  key :title, String, :required => true, :allow_blank => false, :unique => true
  key :body, String, :required => true, :allow_blank => false
  key :slug, String, :unique => true
  key :tags, Array
  timestamps!

  belongs_to :user
  many :comments

  before_create :make_slug

  RegTagsOk = /\A([A-Z\s\-]+;?)*\z/i

  validates_associated :comments
  validates_length_of :title, :within => 4..40
  validates_format_of :named_tags, :with => RegTagsOk

  def named_tags=(given_tags)
    write_attribute(:tags, given_tags.split(/;\s*/).map {|t| t.downcase})
  end

  def named_tags
    self.tags.join('; ')
  end

  def updated?
    self.updated_at > self.created_at
  end

  def month
    self.created_at.strftime('%B %Y')
  end

  private
    def make_slug
      write_attribute(:slug,
        self.title.downcase.gsub(/ /, '-').gsub(/[^a-z0-9-]/, '').squeeze('-')
      )
    end
  # private
end

class Post
  include MongoMapper::Document

  key :user_id, ObjectId
  key :title, String, :required => true, :allow_blank => false, :unique => true
  key :body, String, :required => true, :allow_blank => false
  key :slug, String, :unique => true
  key :tags, Array
  key :published, Boolean, :default => false
  key :published_at, Time
  key :position, Integer, :default => 0
  timestamps!

  before_create :make_slug
  before_create :set_position
  before_save :update_published_at

  belongs_to :user
  many :comments

  RegTagsOk = /\A([A-Z\s\-]+;?)*\z/i

  validates_associated :comments
  validates_length_of :title, :within => 4..40
  validates_format_of :tag_names, :with => RegTagsOk

  def to_param
    [self.position, self.slug].join('-')
  end

  def tag_names=(given_tags)
    write_attribute(:tags, given_tags.split(/;\s*/).map {|t| t.downcase})
  end

  def tag_names
    self.tags.join('; ')
  end

  def updated?
    self.updated_at > self.published_at if self.published_at
  end

  def month
    self.created_at.strftime('%B %Y')
  end

  private
    def make_slug
      write_attribute(:slug, self.title.downcase.gsub(/ /, '-').gsub(/[^a-z0-9-]/, '').squeeze('-'))
    end

    def set_position
      write_attribute(:position, (Post.all.map(&:position).max + 1 rescue 1))
    end

    def update_published_at
      write_attribute(:published_at, Time.now) if self.published and !self.published_at
    end
  # private
end

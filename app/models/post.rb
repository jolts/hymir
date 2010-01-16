class Post
  include MongoMapper::Document

  key :user_id, ObjectId
  key :title, String, :required => true, :allow_blank => false, :unique => true
  key :body, String, :required => true, :allow_blank => false
  key :slug, String, :unique => true
  key :tags, Array
  key :published, Boolean, :default => false
  key :published_at, Time
  timestamps!
  userstamps!

  before_create :make_slug
  before_save :update_published_at

  belongs_to :user
  has_many :comments

  RegTagsOk = /\A([A-Z\s\-]+;?)*\z/i

  validates_associated :comments
  validates_length_of :title, :within => 4..40
  validates_format_of :tag_names, :with => RegTagsOk

  def to_param
    slug
  end

  def tag_names=(given_tags)
    write_attribute(:tags, given_tags.split(/;\s*/).map(&:downcase))
  end

  def tag_names
    tags.join('; ')
  end

  def updated?
    updated_at > published_or_created_at
  end

  def month
    I18n.l(published_or_created_at, :format => :month)
  end

  def published_or_created_at
    published_at || created_at
  end

  private
    def make_slug
      write_attribute(:slug, title.downcase.gsub(/ /, '-').gsub(/[^a-z0-9-]/, '').squeeze('-'))
    end

    def update_published_at
      write_attribute(:published_at, Time.now) if published and !published_at
    end
  # private
end

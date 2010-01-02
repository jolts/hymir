class Post
  include MongoMapper::Document

  key :user_id, ObjectId
  key :title, String, :required => true, :allow_blank => false, :unique => true
  key :body, String, :required => true, :allow_blank => false
  key :slug, String, :unique => true
  key :tags, Array
  timestamps!

  belongs_to :user

  before_create :make_slug

  TagsFormat = /.*/i # FIXME

  validates_length_of :title, :within => 4..40
  validates_format_of :named_tags, :with => TagsFormat

  def named_tags=(given_tags)
    write_attribute(:tags, given_tags.split(/;\s*/).map {|t| t.downcase})
  end

  def named_tags
    self.tags.join('; ')
  end

  private
    def make_slug
      write_attribute(:slug,
        self.title.downcase.gsub(/ /, '-').gsub(/[^a-z0-9-]/, '').squeeze('-')
      )
    end
  # private
end

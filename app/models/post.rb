class Post < ActiveRecord::Base
  scope :recent, -> { order("created_at DESC").limit(5) }

  before_save :titleize_title, :make_slug

  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  def make_slug
    self.slug = "new-post"
  end
end

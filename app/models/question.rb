class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  has_many :favorites, dependent: :destroy
  has_many :favoriting_users, through: :likes, source: :user


  validates :title, presence: {message: "must be present"},
                    uniqueness: {scope: :body},
                    length: {minimum: 3}
  validates :body, presence: true

  validates :view_count, presence: true,
  numericality: {greater_than_or_equal_to: 0}

def user_name
  if user
    # "#{user.first_name} #{user.last_name}".strip
    # best put that in the user class
    user.full_name
  else
    "Anonymous"
  end
end


#  validates :email, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
# scope: recent, lambda { order(:created_at).reverse_order}
# scope: recent, -> { order(:created_at).reverse_order}

after_initialize :set_defaults
before_save :capitalize_title

scope :recent, lambda { order(:created_at).reverse_order }
scope :recent, -> { order(:created_at).reverse_order }
def self.recent
  order(:created_at).reverse_order
end

def self.search(item)
  # thing = "%#{item}%"
  # where(["title ILIKE ? OR body ILIKE ?", thing, thing])

  search_term = "%#{item}%"
  # where("title || ' ' || body ILIKE ? ", search_term)
  where(["title ILIKE :term OR body ILIKE :term", {term: search_term}])
end

def self.search_multiple(words)
  query   = []
  terms   = []
  words.split.each do |word|
    search_term   = "%#{word}%"
    terms << search_term
    terms << search_term
    query << "title ILIKE ? OR body ILIKE ?"
  end
  where([query.join(" OR ")] + terms)
end

def self.ten
  limit(10)
end

delegate :name, to: :category, prefix: true

# def category_name
#   category.name
# end

def like_for(user)
  likes.find_by_user_id(user.id)
end

def favorite_for(user)
  favorites.find_by_user_id(user.id)
end

  private

  def no_monkey
    if title.present? && title.include?("monkey")
      #This will add to the errors object attached to the current object. If the
      # errors object is not an empty Hash then rails treats the record as invalid
      errors.add(:title, "can't have monkey!")
    end
  end

  def set_defaults
    self.view_count ||=0
  end

  def capitalize_title
    # self.title.capitalize!
    self.title = title.capitalize
  end
end

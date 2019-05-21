class Scholarity
  validates :name, :abbr, presence: true, uniqueness: { case_sensitive: false }

  has_many :researchers, dependent: :destroy
end
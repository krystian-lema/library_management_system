class Book < ApplicationRecord
  belongs_to :library
  has_one :borrow
  has_many :borrow_archives

  validates :title, presence: true
  validates :author, presence: true
  validates :edition, presence: true
  validates :publication_date, presence: true
  validates :ISBN, presence: true
  validates :signature, presence: true
  validates :library_id, presence: true

  def  borrowed
  	return !borrow.blank?
	end

	def end_borrow_date
		return borrow.start_date
	end

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
    #where("author LIKE ?", "%#{search}%")
  end
end

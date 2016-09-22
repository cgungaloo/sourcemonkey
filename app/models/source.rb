class Source < ApplicationRecord
	belongs_to :fact
	has_many :upvotes, dependent: :destroy
	has_many :downvotes, dependent: :destroy
end

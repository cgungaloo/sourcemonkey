class Downvote < ApplicationRecord
	belongs_to :source
	belongs_to :user
	validates_uniqueness_of :user_id, scope: :source_id
end

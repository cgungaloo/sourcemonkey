class Fact < ApplicationRecord
  belongs_to :user
	has_many :sources


  def self.search(search)
  	if search

  		if self.where("title like ?", "%#{search}%").count ==0
  			self.all
  		else
  			self.where("title like ?", "%#{search}%")
  		end

  	else
    	self.all
  	end

  end
end

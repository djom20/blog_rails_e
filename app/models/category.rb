class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_many :categorizations
	has_many :articles, through: :categorizations
	def to_s
		name
	end
end

class Article < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged
    validates_presence_of :title, :body
	after_save :store_image
	PHOTO_STORE = File.join Rails.root, 'public', 'photo_store'
	attr_accessible :title, :body,:photo, :category_list
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :categorizations
	has_many :categories, through: :categorizations, dependent: :destroy
	def category_list=(categories_string)
		self.categorizations.destroy_all
		category_names =categories_string.split(",").collect{|s| s.strip.downcase}.uniq
		category_names.each do |c|
			category = Category.find_or_create_by_name(c)
			categori = self.categorizations.new
			categori.category_id = category.id
		end
	end
	def photo=(file_data)
		unless file_data.blank?
			@file_data = file_data
			self.extension = file_data.original_filename.split('.').last.downcase
		end
	end
	def photo_filename
		File.join PHOTO_STORE, "#{id}.#{extension}"
	end
	def photo_path
		"/photo_store/#{id}.#{extension}"
	end
	def has_photo?
		File.exists? photo_filename
	end
	
	private

	def store_image
		if @file_data
			FileUtils.mkdir_p PHOTO_STORE
			File.open(photo_filename,'wb') do |f|
				f.write(@file_data.read)
			end
			@file_data = nil
		end
	end

end

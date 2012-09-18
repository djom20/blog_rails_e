class User < ActiveRecord::Base
  has_many :articles
  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation, :username, :about

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
end

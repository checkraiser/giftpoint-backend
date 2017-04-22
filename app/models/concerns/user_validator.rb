module UserValidator
  extend ActiveSupport::Concern

  included do 
  	validates :email, presence: true, uniqueness: true
  	validates :name, presence: true
  end
end
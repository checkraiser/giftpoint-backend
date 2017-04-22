module CustomerValidator
  extend ActiveSupport::Concern

  included do 
  	validates :name, presence: true
  	validates :phone, presence: true, uniqueness: true  	
  end
end
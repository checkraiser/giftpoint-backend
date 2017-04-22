module ProductValidator
  extend ActiveSupport::Concern

  included do 
  	validates :name, presence: true
  	validates :code, presence: true, uniqueness: true
  	validates :price, presence: true, numericality: { greater_than: 0 }
  	validates :unit, presence: true
  end
end
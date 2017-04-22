module UserScope
  extend ActiveSupport::Concern

  included do 
  	scope :admin, -> { where("level = 1")}
  	scope :reseller, -> { where("level = 2")}
  end
end

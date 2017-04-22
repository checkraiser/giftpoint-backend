module UserScope
  extend ActiveSupport::Concern

  included do 
  	scope :admin, -> { where("level = 1")}
  	scope :reseller, -> { where("level = 2")}
  end

  def admin?
  	level == 1
  end

  def acts_as_reseller?
  	admin? || level == 2
  end
end

class PotentialResellersQuery < ApplicationQuery
  def initialize
  	@query = SqlQuery.new(:potential_resellers)
  end
end
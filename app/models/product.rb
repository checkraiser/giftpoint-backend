class Product < ApplicationRecord
  include ProductValidator, 
  		  ProductAssociation
end

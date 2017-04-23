class User < ApplicationRecord  
  include Authenticable, 
  		  UserScope, 
  		  UserValidator
end

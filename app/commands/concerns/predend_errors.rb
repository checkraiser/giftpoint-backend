module PrependErrors
  extend ActiveSupport::Concern

  included do 
  	prepend SimpleCommand
  end

  def prepend_errors(model)
  	if model.errors.respond_to?(:messages)
	  	model.errors.messages.each do |k,v|
	  	  errors.add k, v[0]
	  	end
	else
		model.errors.each do |k, v|
			errors.add k, v[0]
		end
	end
  end
end
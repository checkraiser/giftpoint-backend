class BaseCommand

  def self.get_dependencies
    return if self.dependencies.empty?
    self.dependencies.each do |dep|
      p dep
      dep.get_dependencies
    end
  end

  def transaction(&block)
  	ActiveRecord::Base.transaction do 
  	  block.call
  	end
  end

  def rollback(message)
  	raise ActiveRecord::Rollback, message
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

  def convert x
    Float(x)
    i, f = x.to_i, x.to_f
    i == f ? i : f
  rescue ArgumentError
    x
  end

  def prepend_zero(x)
    "0" + x.to_s
  rescue => e 
    x
  end
end

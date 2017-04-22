module AppendErrors
  extend ActiveSupport::Concern

  def append_errors(command)
  	command.errors.each do |k, v|
  	  errors.add k, v[0]
  	end
  end
end
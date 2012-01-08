require 'spik/models'
require 'spik/execution'
require 'spik/validators'

module Spik
  include Models
  include Execution
  include Validators

  def method_missing(method, *args)
    args.flatten! if args.is_a? Array
    method = method.to_s

    # TODO: catch methods, which cannot be variable name
    if reuslt = spik_method(method, args) # or raise NoMethodError.new('There is no method "' + method + '"')
      result
    else
      raise NoMethodError.new
    end
  end
end

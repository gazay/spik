require 'spik/models'
require 'spik/execution'

module Spik
  include Models
  include Execution

  WHICH_NAMES = %w(all first)
  METHOD_NAMES = %w(find delete)

  def method_missing(method, *args)
    args.flatten! if args.is_a? Array
    method = method.to_s
    if model_names.include?(method)
      [method, args]
    elsif model_names.include?(method[0..-2])
      [method[0..-2], args]
    elsif WHICH_NAMES.include?(method)
      if args[0] !~ /@/
        [method, args].flatten
      else
        args[0]
      end
    elsif METHOD_NAMES.include?(method)
      if args[0] !~ /@/
        execute_method(method, args)
      else
        instance_variable_get(args[0])
      end
    elsif !attributes.select{ |k,v| v.include? method }.empty?
      if args[0] == 'like'
        method + ' LIKE "%' + args[1] + '%"'
      elsif args[0].is_a? String
        method + ' = \'' + args[0] + '\''
      else
        method + ' = ' + args[0].to_s
      end
    elsif !class_methods.select{ |k,v| v.include? method.to_sym }.empty?
      execute_class_method(method, args[0], args[1])
    elsif method == 'like'
      [method, args]
    elsif %w(with which has have who from).include? method
      args.flatten
    elsif method == 'as'
      ['as__' + args[0], args[1..-1]]
    else
      [method, args]
    end
  end
end
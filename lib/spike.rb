require 'spike/models'
require 'spike/execution'

module Spike
  include Models
  include Execution

  WHICH_NAMES = %w(all first)
  METHOD_NAMES = %w(find delete)

  def method_missing(method, *args)
    Rails.logger.info args.class.to_s + ' ---->> ' + args.to_s + ' by: ' + method.to_s
    args.flatten! if args.is_a? Array
    method = method.to_s
    Rails.logger.info '-------- ' + model_names.to_s
    if model_names.include?(method)
      Rails.logger.info 'model_names include this method with s: ' + method
      Rails.logger.info 'args for this method: ' + args.to_s
      Rails.logger.info '-------- '
      [method, args]
    elsif model_names.include?(method[0..-2])
      Rails.logger.info 'model_names include this method without s: ' + method
      Rails.logger.info 'args for this method: ' + args.to_s
      Rails.logger.info '-------- '
      [method[0..-2], args]
    elsif WHICH_NAMES.include?(method)
      Rails.logger.info 'which_names include this method: ' + method
      Rails.logger.info 'args for this method: ' + args.to_s
      Rails.logger.info '-------- '
      if args[0] !~ /@/
        [method, args].flatten
      else
        args[0]
      end
    elsif METHOD_NAMES.include?(method)
      Rails.logger.info 'method_names include this method: ' + method
      Rails.logger.info 'args for this method: ' + args.to_s
      Rails.logger.info '-------- '
      if args[0] !~ /@/
        Rails.logger.info 'this one you looking for: ' + args.to_s
        execute_method(method, args)
      else
        instance_variable_get(args[0])
      end
    elsif !attributes.select{ |k,v| v.include? method }.empty?
      Rails.logger.info 'attributes include this method: ' + method
      Rails.logger.info 'args for this method: ' + args.to_s
      Rails.logger.info '-------- '
      if args[0] == 'like'
        method + ' LIKE "%' + args[1] + '%"'
      elsif args[0].is_a? String
        method + ' = \'' + args[0] + '\''
      else
        method + ' = ' + args[0].to_s
      end
    elsif method == 'like'
      [method, args]
    elsif %w(with which has have).include? method
      args.flatten
    elsif method == 'as'
      ['as__' + args[0], args[1..-1]]
    else
      Rails.logger.info 'here was unhandled method: ' + method
      Rails.logger.info 'args for this method: ' + args.to_s
      Rails.logger.info '-------- '
      [method, args]
    end
  end
end
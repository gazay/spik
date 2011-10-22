module Spike
  WHICH_NAMES = %w(all first)
  METHOD_NAMES = %w(find delete)

  def method_missing(method, *args)
    Rails.logger.info args.class.to_s + ' ---->> ' + args.to_s
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
      if args[0].is_a? String
        method + ' = \'' + args[0] + '\''
      else
        method + ' = ' + args[0].to_s
      end
    elsif %w(with which has have).include? method
      args.flatten
    else
      Rails.logger.info '!!!!!!!!!+++++++++++!!!!!!!!!! ' + method + ' ---- ' + args.to_s
    end
  end

  def execute_method(method, args)
    Rails.logger.info 'in model: ' + args[1].capitalize + ', execute method: ' + method + ', with args: ' + args.to_s
    if method == 'delete'
      if args[0] == 'all'
        args[1].capitalize.constantize.send('delete_all', args[2])
      elsif args[2] =~ /id/
        id = args[2].match(/(\d+)/)[0]
        args[1].capitalize.constantize.send('delete', id)
      elsif args[1] =~ /id/
        id = args[1].match(/(\d+)/)[0]
        args[0].capitalize.constantize.send('delete', id)
      end
    else
      if args[0] == 'all'
        if args.size > 2
          instance_variable_set(('@' + args[1] + 's'), args[1].capitalize.constantize.send(method, args[0].to_sym, :conditions => args[2]))
        else
          instance_variable_set(('@' + args[1] + 's'), args[1].capitalize.constantize.send(method, args[0].to_sym))
        end
      else
        instance_variable_set(('@' + args[1]), args[1].capitalize.constantize.send(method, args[0].to_sym))
      end
    end
  end

  def model_names
    @@model_names ||= ActiveRecord::Base.subclasses.map{ |it| it.to_s.downcase }
  end

  def attributes
    @@attribute_names ||= {}.tap do |hash|
      model_names.each do |model_name|
        hash[model_name] = model_name.capitalize.constantize.attribute_names
      end
    end
  end
end

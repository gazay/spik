module Spik
  module Validators
    WHICH_NAMES = %w(all first)
    METHOD_NAMES = %w(find delete)

    def spik_method(method, args)
      if model_names.include?(method)
        return_value_of(:model, method, args)
      elsif model_names.include?(method[0..-2])
        return_value_of(:model, method[0..-2], args)
      elsif WHICH_NAMES.include?(method)
        return_value_of(:which, method, args)
      elsif METHOD_NAMES.include?(method)
        return_value_of(:method, method, args)
      elsif !attributes.select{ |k,v| v.include? method }.empty?
        return_value_of(:attribute, method, args)
      elsif !class_methods.select{ |k,v| v.include? method.to_sym }.empty?
        return_value_of(:class_method, method, args)
      elsif method == 'like'
        return_value_of(:like, method, args)
      elsif %w(with which has have who from).include? method
        return_value_of(:keyword, method, args)
      elsif method == 'as'
        return_value_of(:alias, method, args)
      else
        return_value_of(:variable, method, args)
      end
    end

    def return_value_of(type, method, args)
      case type
        when :model, :like, :variable
          [method, args]
        when :which
          if args[0] !~ /@/
            [method, args].flatten
          else
            args[0]
          end
        when :sql_method
          if args[0] !~ /@/
            execute_method(method, args)
          else
            instance_variable_get(args[0])
          end
        when :attribute
          if args[0] == 'like'
            method + ' LIKE "%' + args[1] + '%"'
          elsif args[0].is_a? String
            method + ' = \'' + args[0] + '\''
          else
            method + ' = ' + args[0].to_s
          end
        when :class_method
          execute_class_method(method, args[0], args[1])
        when :keyword
          args.flatten
        when :alias
          ['as__' + args[0], args[1..-1]]
      end
    end
  end
end
module Spike
  MODEL_NAMES = %w(post)
  WHICH_NAMES = %w(all first)
  METHOD_NAMES = %w(find delete)

  def method_missing(m, *a)
    m = m.to_s
    Rails.logger.info m

    if MODEL_NAMES.include?(m)
      variable_method(m)
    elsif MODEL_NAMES.include?(m[0..-2])
      variable_method(m[0..-2])
    elsif WHICH_NAMES.include?(m)
      if a[0] !~ /@/
        [m, a[0]]
      else
        a[0]
      end
    elsif METHOD_NAMES.include?(m)
      if a[0].is_a? Array
        execute_method(m, a[0])
      else
        instance_variable_get(a[0])
      end
    end
  end
  
  def variable_method(model_name)
    instance_variable_get('@' + model_name) && '@' + model_name || model_name
  end

  def execute_method(method, args)
    if args[0] == 'all'
      instance_variable_set(('@' + args[1] + 's'), args[1].capitalize.constantize.send(method, args[0].to_sym))
    else
      instance_variable_set(('@' + args[1]), args[1].capitalize.constantize.send(method, args[0].to_sym))
    end
  end
end

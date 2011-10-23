module Spike
  module Execution
    def execute_method(method, args)
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
        variable_name = args.find{ |it| it =~ /as__/ } || '@' + args[1]
        if variable_name =~ /as__/
          variable_name = '@' + variable_name.split('__').last
        elsif args[0] == 'all'
          variable_name += 's'
        end
        if args.size > 2
          instance_variable_set((variable_name), args[1].capitalize.constantize.send(method, args[0].to_sym, :conditions => args.last))
        else
          instance_variable_set((variable_name), args[1].capitalize.constantize.send(method, args[0].to_sym))
        end
      end
    end
  end
end
module Spik
  module Models
    def model_names
      @model_names ||= ActiveRecord::Base.subclasses.map{ |it| it.to_s.downcase }
    end

    def attributes
      @attribute_names ||= {}.tap do |hash|
        model_names.each do |model_name|
          hash[model_name] = model_name.capitalize.constantize.attribute_names
        end
      end
    end

    def class_methods
      @class_method_names ||= {}.tap do |hash|
        base_public_methods = ActiveRecord::Base.public_methods + [:original_table_name, :original_locking_column]
        model_names.each do |model_name|
          hash[model_name] = model_name.capitalize.constantize.public_methods - base_public_methods
        end
      end
    end
  end
end
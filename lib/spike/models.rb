module Spike
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
  end
end
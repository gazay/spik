# spik_spec_rb
require 'spik'
require 'spec_helper'

describe Spik do
  before do
    @controller = HomeController.new
  end

  it 'should be included in HomeController' do
    HomeController.included_modules.include?(Spik).should == true
  end

  it 'should get all model_names from dummy application' do
    @controller.model_names.should include('post', 'notice')
  end

  it 'should get all attributes from models' do
    @controller.attributes['post'].should == Post.attribute_names
    @controller.attributes['notice'].should == Notice.attribute_names
  end

  it 'should get all class methods for model' do
    base_class_methods = ActiveRecord::Base.public_methods + [:original_table_name, :original_locking_column]
    @controller.class_methods['post'].should == Post.public_methods - base_class_methods
  end

  it 'should catch all keywords' do
    expect {
      @controller.find
      @controller.delete
      @controller.all
      @controller.delete
      @controller.which
      @controller.who
      @controller.from
      @controller.has
      @controller.have
    }.to_not raise_error
  end
end
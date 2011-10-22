require 'test_helper'

class MissingMethodTest < ActiveSupport::IntegrationCase
  test 'pdf request sends a pdf as file' do
    visit home_path
  end

  protected
  def headers
    page.response_headers
  end
end
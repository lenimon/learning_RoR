require 'spec_helper'

describe UsersController do
 render_views

  before(:each) do
   @base_title = 'Ruby on Rails Tutorial Sample App | '
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
end

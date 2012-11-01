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
  describe "GET 'show'" do
    before(:each) do
      @user =  FactoryGirl.create(:user);
    end
    it 'should return http success' do
      get :show, :id=>@user
      response.should be_success
    end
    it 'should get the expected user' do
      get :show, :id=>@user
      assigns(:user).should == @user
    end
    it 'should have the right title' do
      get :show, :id=>@user
      response.should have_selector('title', :content=>@user.name)
    end
    it 'should have the user name in heading' do
      get :show, :id=>@user
      response.should have_selector('h1', :content=>@user.name)
    end
    it 'should have a profile image' do
      get :show, :id=>@user
      response.should have_selector('h1>img', :class=>'gravatar')
    end
  end
end
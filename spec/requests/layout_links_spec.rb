require 'spec_helper'
describe "LayoutLinks" do
	it "should have a Home page at '/'" do
	  get '/'
	  response.should have_selector('title', :content => "dynamic home variable")
	end
	it "should have a Contact page at '/contact'" do
	  get '/contact'
	  response.should have_selector('title', :content => "dynamic contact variable")
	end
	it "should have an About page at '/about'" do
	  get '/about'
	  response.should have_selector('title', :content => "dynamic about variable")
	end
	it "should have a Help page at '/help'" do
	  get '/help'
	  response.should have_selector('title', :content => "dynamic help variable")
	end
	it "should have a SignUp page at /sign_up" do
	  get '/sign_up'
	  response.should have_selector('title', :content => "Sign Up")
	end

	it "should have the right links to click" do
	  visit root_path
	  click_link "About"
	  response.should have_selector("title", :content=>"dynamic about variable")
	  click_link "Contact"
	  response.should have_selector("title", :content=>"dynamic contact variable")
	  click_link "Help"
	  response.should have_selector("title", :content=>"dynamic help variable")
	  click_link "Sign Up"
	  response.should have_selector("title", :content=>"Sign Up")
	end
end


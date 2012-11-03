require 'spec_helper'

describe "Users" do
  describe "Sign Up" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit sign_up_path
          fill_in "Name", :with=>''
          fill_in "Email", :with=>''
          fill_in "Password", :with=>''
          fill_in "Confirmation", :with=>''
          click_button
          response.should render_template('users/new')
          response.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end
    describe "success" do
      it "should make a new user" do
        lambda do
          visit sign_up_path
          fill_in "Name", :with=>'Test Name'
          fill_in "Email", :with=>'test_email@mail.com'
          fill_in "Password", :with=>'test_password'
          fill_in "Confirmation", :with=>'test_password'
          click_button
          response.should have_selector("div.flash.success", :content=>"Welcome")
          response.should render_template('users/show')
          end.should change(User,:count).by(1)
      end
    end
  end
end

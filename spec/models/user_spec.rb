# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe User do
  before(:each){
    @attr = {:name=>'examples',:email=>'examples@mail.com',:password=>'testpassword', :password_confirmation=>'testpassword'}
  }
  describe "User model factory" do
    it "has a valid factory" do
      FactoryGirl.create(:user).should be_valid
    end
  end
  it 'should create a new user instance provided valid attributes' do
    User.create!(@attr)
  end
  it 'should require a name' do
    no_name_user = User.new(@attr.merge(:name=>''))
    no_name_user.should_not be_valid
  end
  it 'should require an email address' do
    no_email_user = User.new(@attr.merge(:email=>''))
    no_email_user.should_not be_valid
  end
  it 'should not have too long name' do
    long_name = 'a'*100
    long_name_user = User.new(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end
  it 'should accept valid email address' do
    address_arr = %w[test@email.com TEST@email.com test.TEST@email.com]
    address_arr.each do |address|
      user = User.new(@attr.merge(:email=>address))
      user.should be_valid
    end
  end
  it 'should not accept invalid email addresses' do 
    address_arr = %w[test 1234 @#$%$]
    address_arr.each do |address|
      user = User.new(@attr.merge(:email=>address))
      user.should_not be_valid
    end
  end
  it 'should allow unique email address only' do
    non_unique_email = 'test@email.com'
    User.create!(@attr.merge(:email=>non_unique_email))
    user = User.new(@attr.merge(:email=>non_unique_email))
    user.should_not be_valid
  end
  it 'should not allow unique email address with case difference' do
    User.create!(@attr.merge(:email=>@attr[:email].upcase))
    user = User.new(@attr)
    user.should_not be_valid
  end
  it 'should have password and confirmation filled' do
    user = User.new(@attr.merge(:password=>'',:password_confirmation=>''))
    user.should_not be_valid
  end
  it 'should have matching password and password_confirmation' do
    user = User.new(@attr.merge(:password_confirmation=>'someotherpassword'))
    user.should_not be_valid
  end
  it 'should reject very short passwords' do
    shortPass = 'a'*5
    user = User.new(@attr.merge(:password=>shortPass,:password_confirmation=>shortPass))
    user.should_not be_valid
  end
  it 'should reject very long passwords' do
    longPass = 'a'*41
    user = User.new(@attr.merge(:password=>longPass,:password_confirmation=>longPass))
    user.should_not be_valid
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    it 'password should not be blank' do
      @user.encrypted_password.should_not be_blank
    end
    describe "has_password? method check" do
      it "matching password should pass" do
        @user.has_password?(@attr[:password]).should be_true
      end
      it "non matching password should not pass" do
        @user.has_password?('invalid').should be_false
      end
    end
    describe "authenticate method check" do
      it 'should return nil for email/password mismatch'do
        wrong_password_user = User.authenticate(@attr[:email],'wrongpassword')
        wrong_password_user.should be_nil
      end
      it 'should return nil for non existant user'do
        wrong_user = User.authenticate('wrong@user.com',@attr[:password])
        wrong_user.should be_nil
      end
      it 'should return user for valid email/password combination'do
        valid_user = User.authenticate(@attr[:email],@attr[:password])
        valid_user.should == @user
      end
    end
  end
end

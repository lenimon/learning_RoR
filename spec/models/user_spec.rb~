# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before(:each){
    @attr = {:name=>'example',:email=>'example@mail.com'}
  }
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
end

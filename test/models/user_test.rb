require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter a first name" do
    user = User.new
    assert !user.save 
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save 
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save 
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:cat).profile_name
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should be have a profile name without spaces" do
    user = User.new(first_name: "Cat", last_name: "Cat", email: "catcatcat@gmail.com")
    user.password = user.password_confirmation = 'qwertyui'
    
    user.profile_name = "My Profile With Spaces"
    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must contain only letters, - or _")
  end

# it doesn't pass
  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: "Kitten", last_name: "Little", email: "littlekitten@gmail.com")
    user.password = user.password_confirmation = 'qwertyui'

    user.profile_name = "LittleKitten"
    assert user.valid? 
  end

end

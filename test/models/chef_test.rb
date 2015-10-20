require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Bob Burgers", email: "bobsburgers@gmail.com")
  end
  
  test "chefname must be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test "chefname can't be too short" do
    @chef.chefname = "ab"
    assert_not @chef.valid?
  end
  
  test "chefname can't be too long" do
    @chef.chefname = "a" * 40
    assert_not @chef.valid?
  end
   
  test "chefname must be between 3 and 40 characters" do
    @chef.chefname = "bob burgers"
    assert @chef.valid?
  end
  test "email must be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  test "email must be unique" do
    chefdup = @chef.dup
    @chef.save
    assert_not chefdup.valid?
  end
  test "email must not be too long" do
    @chef.email = "a" * 106 + "@gmail.com"
    assert_not @chef.valid?
  end
  test "email must be 150 characters or less" do
    @chef.email = "jimlol@gmail.com"
    assert @chef.valid?
  end
  test "email validation should accept valid addresses" do
    valid_addresssess = %w[user@example.com TDD_BDD@hello.org user@example.com]
    valid_addresssess.each do |va| 
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  test "email validation should reject invalid addressess" do
    invalid_addressess = %w[user@example,com user_@_eee.org user.name@example]
    invalid_addressess.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end
end
require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "Bob Burger", email: "bobsburgers@gmail.com")
    @recipe = Recipe.new(chef_id: @chef.id, name: "chicken parm", summary: "this is the best chicken parm recipe ever", description: "heat oil, add onions, add tomato sauce, add chicken, cook for 20 minutes")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  
  test "name should not be too short" do
    @recipe.name = "1234"
    assert_not @recipe.valid?
  end
  
  test "name should not be too long" do
    @recipe.name = "a" * 100
    assert_not @recipe.valid?
  end
  
  test "name should be between 5 and 99 characters" do
    @recipe.name = "Chicken Parm"
    assert @recipe.valid?
  end
  
  test "summary must be present" do
    @recipe.summary = ""
    assert_not @recipe.valid?
  end
  
  test "summary must not be too short" do
    @recipe.summary = "123456789"
    assert_not @recipe.valid?
  end
  
  test "summary must not be too long" do
    @recipe.summary = "a" * 150
    assert_not @recipe.valid?
  end
  
  test "summary must be between 10 and 150 characters" do
    @recipe.summary = "This is the best recipe ever!"
    assert @recipe.valid?
  end
    test "description must be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  
  test "description must not be too short" do
    @recipe.description = "1234567891234567891"
    assert_not @recipe.valid?
  end
  
  test "description must not be too long" do
    @recipe.description = "a" * 500
    assert_not @recipe.valid?
  end
  
  test "description must be between 10 and 150 characters" do
    @recipe.description= "This is the best recipe ever!"
    assert @recipe.valid?
  end
  
  test "chef_id must be present" do
    @recipe.chef_id = ""
    assert_not @recipe.valid?
  end
end
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should be valid with valid attributes" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'New Product', price: '12.34', quantity: '5', category: @category)
      expect(@product).to be_valid
    end

    it "should not be valid without a name" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: nil, price: '12.34', quantity: '5', category: @category)
      expect(@product).to_not be_valid
    end

    it "should not be valid without a price" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'New Product', price: nil, quantity: '5', category: @category)
      expect(@product).to_not be_valid
    end

    it "should not be valid without a quantity" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'New Product', price: '12.34', quantity: nil, category: @category)
      expect(@product).to_not be_valid
    end

    it "should not be valid without a category" do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(name: 'New Product', price: '12.34', quantity: '5', category: nil)
      expect(@product).to_not be_valid
    end
  end
end

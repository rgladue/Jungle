require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'given all attributes' do
      it 'is valid with valid attributes' do
        @category = Category.find_or_create_by! name: 'Furniture'

        @product =
          @category.products.create(
            { name: 'Coffee Mugs', price: 8, quantity: 2 },
          )
        expect(@product).to be_valid
     
      end
    end

    it 'is not valid without a name' do
      @category = Category.find_or_create_by! name: 'Furniture'

      @product = @category.products.create({ price: 8, quantity: 2 })

      expect(@product).to_not be_valid
    end

    it 'is not valid without a price' do
      @category = Category.find_or_create_by! name: 'Furniture'

      @product = @category.products.create({ name: 'Coffee Mugs', quantity: 2 })

      expect(@product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      @category = Category.find_or_create_by! name: 'Furniture'

      @product = @category.products.create({ name: 'Coffee Mugs', price: 10 })

      expect(@product).to_not be_valid
    end

    it 'is not valid without a category' do
        @product =
        Product.create(
          { name: 'Coffee Mugs', price: 8, quantity: 2, category_id: 1 },
        )

      expect(@product).to_not be_valid
    end
  end
end
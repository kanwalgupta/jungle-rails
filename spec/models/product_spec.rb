RSpec.describe Product, type: :model do
    describe 'Validations' do
      # validation tests/examples here
      it 'should save to the db without errors if all fields are present' do
        @category = Category.create(name: "Test Cat")
        @product = Product.new(
          id: 12345,
          name: "Test Product",
          description: "Kithe gayi",
          image: "image.jpeg",
          price_cents: 25,
          quantity: 15,
          created_at: Time.now,
          updated_at: Time.now,
          category_id: @category.id
        )
        @product.save
        expect(@product).to be_valid
      end
       it 'should not save to the db if name field is not present' do
        @category = Category.create(name: "Test Cat")
        @product = Product.new(
          id: 12345,
          name: nil,
          description: "kithe gayi",
          image: "image.jpeg",
          price_cents: 25,
          quantity: 15,
          created_at: Time.now,
          updated_at: Time.now,
          category_id: @category.id
        )
        @product.save
        expect(@product.errors.full_messages.join("")).to include("Name")
      end
       it 'should not save to the db if price field is not present' do
        @category = Category.create(name: "Test Cat")
        @product = Product.new(
          id: 12345,
          name: "Test Product",
          description: "Yayayayaya",
          image: "image.jpeg",
          quantity: 15,
          price_cents: nil,
          created_at: Time.now,
          updated_at: Time.now,
          category_id: @category.id
        )
        @product.save
        expect(@product.errors.full_messages.join("")).to include("Price")
      end
       it 'should not save to the db if quantity field is not present' do
        @category = Category.create(name: "Test Cat")
        @product = Product.new(
          id: 12345,
          name: "Test Product",
          description: "Yayayayaya",
          image: "image.jpeg",
          price_cents: 25,
          quantity: nil,
          created_at: Time.now,
          updated_at: Time.now,
          category_id: @category.id
        )
        @product.save
        expect(@product.errors.full_messages.join("")).to include("Quantity")
      end
       it 'should not save to the db if category field is not present' do
        @category = Category.create(name: "Test Cat")
        @product = Product.new(
          id: 12345,
          name: "Test Product",
          description: "Yayayayaya",
          image: "image.jpeg",
          price_cents: 25,
          quantity: 15,
          created_at: Time.now,
          updated_at: Time.now,
          category_id: nil
        )
        @product.save
        expect(@product.errors.full_messages.join("")).to include("Category")
      end
    end
  end
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
  	sequence(:title){|n| "Title_#{n}"}
    sequence(:description){|n| "Description_#{n}"}
    price "9.99"
    photo_url "http://www.google.pl/image.jpg"
    on_sale false

    trait :with_category do
    	after(:create) do |instance|
        FactoryGirl.create_list(:categoryproduct, 1, 
          product: instance, 
          category: FactoryGirl.create(:category))
      end
    end
  end
end

require 'rails_helper'
describe 'ruby 2.3.0' do

  context "Integer methods" do
    describe "positive?" do
      it "checks if an array value is greater than zero" do
        some_array = [2,3,4]

        expect(some_array.first.positive?).to eq true

      end
    end
  end

  context "Method methods" do
    describe "safe navigation operator" do
      it "safely calls a method" do
        obj = nil

        expect{obj.hello?}.to raise_error(NoMethodError, "undefined method `hello?' for nil:NilClass")

        expect(obj&.hello?).to eq nil

        expect(obj.try!(:nil)).to eq nil

      end
    end
  end

  context "Hash, Array and Struct methods" do
    describe "#dig"do
      it "traverses a Hash" do
        post = {
            text: 'Post about dig.',

            user: {
                name: 'David'
            }
        }

        expect(post.dig(:user, :name)).to eq 'David'
      end

      it "traverses a Struct" do
        Tag = Struct.new(:name)

        post = {
            text: 'Post about dig.',

            user: {
                name: 'David'
            },

            tags: [Tag.new('Ruby'), Tag.new('MySQL')]
        }

        expect(post.dig :tags, 0, :name).to eq 'Ruby'
      end

      it "returns nil instead of throwing an exception" do
        post = {
            users:[
                {
                  user: {
                    first_name: 'David',
                    surname: 'Moore'
                  }
                }
            ]

        }

        expect{post[:users][0][:name][:last_name]}.to raise_error(NoMethodError, "undefined method `[]' for nil:NilClass")
        expect(post.dig(:users, 0, :name, :last_name)).to eq nil
      end
    end
  end
end
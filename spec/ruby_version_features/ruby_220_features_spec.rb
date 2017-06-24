require 'rails_helper'
describe 'ruby 2.2.0' do

  context "Enumerable methods" do

    # slice_before, slice_after and slice_when return Enumerable

    describe "#slice_before" do
      it "slices before a matched singular value" do
        a = ["a", "b", "c"]
        sliced_array = a.slice_before("b").to_a

        expect(sliced_array).to eq [["a"], ["b", "c"]]
      end

      it "matches with regular expressions" do
        a = ["000", "b", "999"]
        sliced_array = a.slice_before(/[a-z]/).to_a

        expect(sliced_array).to eq [["000"], ["b", "999"]]
      end

      it "matches values in ranges" do
        a = [100, 200, 300]
        sliced_array = a.slice_before(150..250).to_a

        expect(sliced_array).to eq [[100], [200, 300]]
      end

      it "matches values against class types" do
        a = [1, "200", 1.3]
        sliced_array = a.slice_before(String).to_a

        expect(sliced_array).to eq [[1], ["200", 1.3]]
      end

      it "works with blocks" do
        a = [1, 2, 3, 4, 5]

        sliced_array = a.slice_before do |item|
          item % 2 == 0
        end
                           .to_a

        expect(sliced_array).to eq [[1], [2, 3], [4, 5]]
      end

    end

    describe "#slice_after" do
      it "slices before a matched singular value" do
        a = ["a", "b", "c"]
        sliced_array = a.slice_after("b").to_a

        expect(sliced_array).to eq [["a", "b"], ["c"]]
      end

      it "matches with regular expressions" do
        a = ["000", "b", "999"]
        sliced_array = a.slice_after(/[a-z]/).to_a

        expect(sliced_array).to eq [["000", "b"], ["999"]]
      end

      it "matches values in ranges" do
        a = [100, 200, 300]
        sliced_array = a.slice_after(150..250).to_a

        expect(sliced_array).to eq [[100, 200], [300]]
      end

      it "matches values against class types" do
        a = [1, "200", 1.3]
        sliced_array = a.slice_after(String).to_a

        expect(sliced_array).to eq [[1, "200"], [1.3]]
      end

      it "works with blocks" do
        a = [1, 2, 3, 4, 5]

        sliced_array = a.slice_after do |item|
          item % 2 == 0
        end
                           .to_a

        expect(sliced_array).to eq [[1, 2], [3, 4], [5]]
      end

    end

    describe "#slice_when" do
      it "slices when a condition is met between a pair of values in an array" do
        a = [1, 2, 3, 100, 101, 102]

        sliced_array = a.slice_when do |x, y|
          (y - x) > 10
        end
                           .to_a

        expect(sliced_array).to eq [[1, 2, 3], [100, 101, 102]]

      end
    end
  end

  context "File methods" do
    # Do not work on Linux/GNU!!! TBC
    describe "#birthtime" do
      it "returns the time and date of a file" do
        file = File.open("#{Rails.root}/spec/fixtures/text_report.txt")

        expect(file.birthtime).to eq "2017-03-12 20:25:40 -0700"
      end
    end

    describe ".birthtime" do
      it "returns a time and date of a file" do
        file = File.open("#{Rails.root}/spec/fixtures/text_report.txt")

        expect(File.birthtime(file)).to eq "2017-03-12 20:25:40 -0700"
      end
    end
  end

  context "Method methods" do
    describe "#super_method" do
      it "returns the method of a superclass" do

        class Parent
          def name
            "I am the parent!"
          end
        end

        class Child < Parent
          def name
            "I am the child!"
          end
        end

        parent = Parent.new

        expect(parent.name).to eq "I am the parent!"

        child = Child.new

        expect(child.name).to eq "I am the child!"
        expect{child.name.super_method}.to raise_error(NoMethodError, 'undefined method `super_method\' for "I am the child!":String')
        expect(child.public_method(:name).call).to eq "I am the child!"
        expect(child.public_method(:name).super_method.call).to eq "I am the parent!"

      end
    end
  end


end
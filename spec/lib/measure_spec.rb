require 'rails_helper'
describe Measure do
  it "shows how to run without garbage collection" do
    Measure.run(gc: :disable) { Thing.all.load }
  end
  it "shows that select is faster than all" do
    result = Measure.run { Thing.all.select([:id, :col1, :col5]).load }
    result
  end
end



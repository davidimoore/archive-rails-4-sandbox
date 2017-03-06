require 'rails_helper'

describe 'Optimizing CSV creation' do
  let(:num_rows) { 100000 }
  let(:num_cols) { 10 }
  let(:data)     { Array.new(num_rows) { Array.new(num_cols) { "x"*1000 } } }

  it 'is faster to create line by line' do
    results_with_gc  = Measure.run(gc: :enable) do
      csv = data.map { |row| row.join(",") }.join("\n")
    end

    results_without_gc  = Measure.run(gc: :disable) do
      csv = data.map { |row| row.join(",") }.join("\n")
    end

    expect(results_with_gc.time).to be > results_without_gc.time * 2

  end
end
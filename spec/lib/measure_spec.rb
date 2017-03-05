require 'rails_helper'
describe Measure do

  describe '.run' do
    let(:num_rows) { 100000 }
    let(:num_cols) { 10 }


      it "shows that when gc is enabled the time to execute is greater" do
        data = Array.new(num_rows) { Array.new(num_cols) { "x"*1000 } }

        results_with_gc_enabled  = Measure.run(gc: :enable) { csv = data.map { |row| row.join(",") }.join("\n") }

        expect(results_with_gc_enabled.gc).to eq :enable
        expect(results_with_gc_enabled.gc_count).to be > 0

        results_with_gc_disabled = Measure.run(gc: :disable) { csv = data.map { |row| row.join(",") }.join("\n") }

        expect(results_with_gc_disabled.gc).to eq :disable
        expect(results_with_gc_disabled.gc_count).to eq 0

        # when garbage collection is on only the memory of the measure code is resultsed
        expect(results_with_gc_enabled.memory).to be < results_with_gc_disabled.memory

        # when garbage collection is on the time of execution is lower
        expect(results_with_gc_enabled.time).to be > results_with_gc_disabled.time

    end

    describe '.report' do
      it "prints a results" do
        data = Array.new(num_rows) { Array.new(num_cols) { "x"*1000 } }
        results  = Measure.run(gc: :enable) { csv = data.map { |row| row.join(",") }.join("\n") }
        results.print_report

      end
    end





  end


end



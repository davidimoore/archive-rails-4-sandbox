require 'rails_helper'
describe Benchwarmer do

  describe '.run' do
    let(:num_rows) { 100000 }
    let(:num_cols) { 10 }

    it "shows that when gc is enabled the time to execute is greater" do
      data = Array.new(num_rows) { Array.new(num_cols) { "x"*1000 } }

      results_with_gc_enabled  = described_class.run(gc: :enable) {  data.map { |row| row.join(",") }.join("\n") }

      expect(results_with_gc_enabled.gc).to eq :enable
      expect(results_with_gc_enabled.gc_count).to be > 0

      results_with_gc_disabled = described_class.run(gc: :disable) { data.map { |row| row.join(",") }.join("\n") }

      expect(results_with_gc_disabled.gc).to eq :disable
      expect(results_with_gc_disabled.gc_count).to eq 0

      # when garbage collection is on only the memory of the measure code is resultsed
      expect(results_with_gc_enabled.memory).to be < results_with_gc_disabled.memory

      # when garbage collection is on the time of execution is lower
      expect(results_with_gc_enabled.time).to be > results_with_gc_disabled.time

    end
  end

  describe "#print_report"  do
    let(:results) do
      {
          ruby_version: "2.3.3",
          time: 2.5,
          gc: :enable,
          gc_count_after: 100,
          gc_count_before: 20,
          memory_after: 2000,
          memory_before: 1000
      }
    end

    let(:measure) { described_class.new(results) }

    it "prints a results in text format" do
      report = measure.print_report

      expect(report).to eq "ruby_version: 2.3.3 gc: enable time: 2.5 gc_count: 80 memory: 1000 MB "
    end

    it "prints a results in json format" do
      report = measure.print_report(format: :json )

      expect(report).to eq "{\"ruby_version\":\"2.3.3\",\"gc\":\"enable\",\"time\":2.5,\"gc_count\":80,\"memory\":\"1000 MB\"}"
    end

  end

  describe "#save_report"  do
    let(:results) do
      {
          ruby_version: "2.3.3",
          time: 2.5,
          gc: :enable,
          gc_count_after: 100,
          gc_count_before: 20,
          memory_after: 2000,
          memory_before: 1000
      }
    end
    let(:measure) { described_class.new(results) }
    let(:output_location) { "spec/fixtures" }

    it "creates a text file with a report" do
      measure.save_report(location: output_location, name: 'text_report')
      file = File.open("#{Rails.root}/spec/fixtures/text_report.txt")

      expect(file.read).to eq "ruby_version: 2.3.3 gc: enable time: 2.5 gc_count: 80 memory: 1000 MB \n"
    end

    it "prints a results in json format" do
      measure.save_report(location: output_location, name: 'text_report', format: :json)
      file = File.open("#{Rails.root}/spec/fixtures/text_report.json")

      expect(file.read).to eq "{\"ruby_version\":\"2.3.3\",\"gc\":\"enable\",\"time\":2.5,\"gc_count\":80,\"memory\":\"1000 MB\"}\n"
    end

  end

end



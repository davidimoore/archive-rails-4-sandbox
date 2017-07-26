require 'rails_helper'
require_relative '../support/data/sql_seeds'
RSpec.describe 'ActiveRecord performance' do
  context 'select vs all' do
    it 'is faster to select specific columns' do
      ActiveRecord::Base.connection.execute many_things_seed

      results_for_all = Benchwarmer.run(gc: :disabled) {Thing.all.load}

      results_for_select = Benchwarmer.run(gc: :disabled) {Thing.select([:id, :col1, :col5]).load}

      expect(results_for_all.memory).to be > results_for_select.memory
      expect(results_for_all.time).to be > results_for_select.time


    end
  end
end
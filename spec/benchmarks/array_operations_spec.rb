require 'rails_helper'

describe 'My behaviour' do
  let(:num_rows) { 100000 }
  let(:num_cols) { 10 }
  it 'measures different ways of parsing strings to arrays' do
    #"0,1,2,3,...999"
    string_of_comma_separated_nums = (0..19999).to_a.inject("") {|str, v| str += "#{v}," }[0...-1]

   measurement =  Benchwarmer.run({gc: :disable}) do

     out = []

      string_of_comma_separated_nums.to_s.split(',').each do |to_id|
        to_id = to_id.strip
        if to_id.to_i > 0 && to_id.to_i.to_s == to_id
          out << to_id.to_i
        end
      end
      out
   end



    ap measurement.results


  end
end
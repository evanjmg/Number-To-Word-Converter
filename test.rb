# to run tests gem install rspec and rspec test.rb in root in terminal
require_relative 'number_to_word_converter'
require 'rspec'
RSpec.describe 'convert numbers to words' do 
	it { expect(process_number(9)).to eq('nine') }
	it { expect(process_number(0)).to eq('zero') }
	it  { expect(process_number(11)).to eq('eleven') }
	it  { expect(process_number(115)).to eq('one hundred and fifteen') }
	it  { expect(process_number(120)).to eq('one hundred and twenty') }
	it  { expect(process_number(131)).to eq('one hundred and thirty-one') }
	it  { expect(process_number(1000)).to eq('one thousand') }
	it  { expect(process_number(10000)).to eq('ten thousand') }
	it  { expect(process_number(100000)).to eq('one hundred thousand') }
	it  { expect(process_number(1000000)).to eq('one million') }
	it  { expect(process_number(10000000)).to eq('ten million') }
	it  { expect(process_number(100000000)).to eq('one hundred million') }
	it  { expect(process_number(100000040)).to eq('one hundred million, forty') }
	it  { expect(process_number(1000000000)).to eq('one billion') }
	it  { expect(process_number(1000000100)).to eq('one billion, one hundred') }
	it  { expect(process_number(1000001100)).to eq('one billion, one thousand, one hundred') }
	it  { expect(process_number(2148929841901240)).to eq('two quadrillion, one hundred and forty-eight trillion, nine hundred and twenty-nine billion, eight hundred and forty-one million, nine hundred and one thousand, two hundred and forty') }
end

require 'spec_helper'
require 'input_parser'

RSpec.describe InputParser do

  it 'returns error when invalid input' do
    parser = InputParser.new('a => b => d')
    expect { parser.parse }.to raise_error(InputParser::INVALID_INPUT)
  end

  it 'raise error when input is empty' do
    expect { InputParser.new('') }.to raise_error(InputParser::EMPTY_ERROR)
  end  
  
  it 'returns job and dependency' do
    parser = InputParser.new('a => b').parse
    expect(parser.job).to eq('a')
    expect(parser.dependency).to eq('b')
  end  
  
end  
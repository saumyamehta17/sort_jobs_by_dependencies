require 'spec_helper'
require 'jobs'

RSpec.describe Jobs do

  describe 'Job Sorting' do
    
    context 'valid inputs' do

      it 'returns job with no dependency' do
        result = Jobs.new("no_dependency").sort
        expect(result).to eq(['a', 'b', 'c'])
      end

      it 'returns job with dependency' do
        result = Jobs.new('with_dependency').sort
        expect(result).to eq(["a", "f", "c", "b", "d", "e"])
      end  
    end
    
    context 'invalid inputs' do

      it 'returns error with circular dependency' do
        job = Jobs.new('circular_dependency')
        job.sort
        expect(job.error).to eq(Jobs::CIRCULAR_DEPENDENCY_ERROR)
      end
      
      it 'returns error with self dependency' do
        job = Jobs.new('self_dependency')
        job.sort
        expect(job.error).to eq(Jobs::SELF_DEPENDENCY_ERROR)
      end

    end  
  end  
end  

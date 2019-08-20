require_relative 'input_parser'
require 'pry'

class Jobs

  FILE_PATH = 'inputs'
  
  SELF_DEPENDENCY_ERROR = 'jobs can\'t depend on themselves'.freeze
  CIRCULAR_DEPENDENCY_ERROR = 'jobs can\'t have circular dependencies'.freeze

  attr_accessor :dependencies, :result, :error

  def initialize
    @dependencies = {}
    @result = []
  end  

  def sort
    build_dependencies
    sort_by_dependencies
  end  

  private

    def build_dependencies
      File.open(FILE_PATH).each do |line|
        parsed_result = InputParser.new(line).parse
        dependencies[parsed_result.job] = parsed_result.dependency
      end
    end

    def sort_by_dependencies
      visited = Hash[dependencies.keys.collect {|key| [key, false]}]
      job_stack = {}
      dependencies.each_pair do |job, dependency|
        return if error
        sort_helper(visited, job_stack, job) unless visited[job]
      end
      result
    end

    def sort_helper(visited, job_stack, job)
      @error = CIRCULAR_DEPENDENCY_ERROR and return if job_stack[job]
      return if visited[job]

      if dependencies[job]
        job_stack[job] = true
        sort_helper(visited, job_stack, dependencies[job])
      end

      job_stack[job] = false
      visited[job] = true
      result << job
    end  
end  
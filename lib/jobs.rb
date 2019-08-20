require_relative 'input_parser'

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
      visited = Hash[dependencies.keys.map {|k| [k, false]}]
      in_call_stack = {}
      dependencies.each_pair do |job, dependency|
        return if error
        helper(visited, in_call_stack, job) unless visited[job]
      end
      result
    end

    def helper(visited, in_call_stack, job)
      self.error = CIRCULAR_DEPENDENCY_ERROR and return if in_call_stack[job]
      return if visited[job]

      if dependencies[job]
        in_call_stack[job] = true
        helper(visited, in_call_stack, dependencies[job])
      end

      in_call_stack[job] = false
      visited[job] = true
      result << job
    end  
end  
class Jobs
  FILE_PATH = 'inputs'
  SEPARATOR = '=>'.freeze

  attr_accessor :dependencies, :result

  def initialize
    @dependencies = {}
    @result = []
  end  

  def sort
    build_dependencies
  end  

  private

    def build_dependencies
      File.open(FILE_PATH).each do |line|
        parsed_result = classify(input)
        dependencies[parsed_result.job] = parsed_result.dependency
      end
    end

    def classify(input)
      inputs = input.split(SEPARATOR)

      job = inputs.first.strip
      dependency = inputs.last.strip if (inputs.length > 1 and not inputs.last.strip.empty?)
      job, dependency    
    end  
end  
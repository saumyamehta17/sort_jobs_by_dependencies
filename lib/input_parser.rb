class InputParser
  SEPARATOR = '=>'.freeze
  EMPTY_ERROR = 'input is empty'.freeze
  INVALID_INPUT = "input is invalid, add one #{SEPARATOR} and two jobs"

  attr_reader :job, :dependency, :input

  def initialize(input)
    @input = input.to_s.strip
    raise EMPTY_ERROR if input.empty?
  end

  def parse
    inputs = input.split(SEPARATOR)
    raise INVALID_INPUT if inputs.length > 2
    @job = inputs.first.strip
    @dependency = inputs.last.strip if (inputs.length > 1 and not inputs.last.strip.empty?)
    self
  end

end  
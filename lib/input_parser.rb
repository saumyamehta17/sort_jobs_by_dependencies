class InputParser
  SEPARATOR = '=>'.freeze

  attr_reader :job, :dependency, :input

  def initialize(input)
    @input = input
  end

  def parse
    inputs = input.split(SEPARATOR)
    @job = inputs.first.strip
    @dependency = inputs.last.strip if (inputs.length > 1 and not inputs.last.strip.empty?)
    self
  end

end  
module Sshconfig
  class Linegroup
    attr_reader :lines

    def initialize
      @lines = []
    end

    def add(line)
      @lines << line
    end

    def to_s
      @lines.join("\n")
    end
  end
end

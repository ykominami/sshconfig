module Sshconfig
  class Sshitem
    attr_reader :name, :value

    def initialize(name, value)
      @name = name
      @value = value
    end

    def valid?
      @value.nil? ? false : true
    end
  end
end

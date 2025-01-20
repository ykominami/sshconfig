# frozen_string_literal: true

require_relative "sshconfig/version"
require_relative "sshconfig/sshitem"
require_relative "sshconfig/sshitemx"
require_relative "sshconfig/linegroup"
require_relative "sshconfig/keyfilegroup"
require_relative "sshconfig/sshconfig"
# ...require other Ruby scripts as needed...

module Sshconfig
  class Error < StandardError; end
  # Your code goes here...
end

module Sshconfig
  require "pathname"

  class Keyfilegroup
    attr_reader :keyfiles

    def initialize(dir_pn)
      @keyfiles = []
      @real_dir_pn = dir_pn.realpath
      @real_dir_pn.children.each do |fn|
        next if fn.directory?

        @keyfiles << fn.relative_path_from(@real_dir_pn).to_s
      end
      # p "@keyfiles.size=#{@keyfiles.size}"
      # p @keyfiles
    end

    def adjust(keyfile)
      if keyfile =~ /^~/
        keyfile.sub(/^~/, ENV["HOME"])
      else
        keyfile
      end
    end

    def relative_path(keyfile)
      adjust_keyfile = adjust(keyfile)
      pn = Pathname.new(adjust_keyfile).realpath
      pn.relative_path_from(@real_dir_pn).to_s
    end

    def remove(keyfile)
      relative_keyfile = relative_path(keyfile)
      @keyfiles.delete(relative_keyfile)
    end
  end

  def keyfiles
    @keyfiles.uniq
  end
end

require_relative "linegroup"
require "pathname"

module Sshconfig
  class Sshconfig
    def initialize(file)
      @file = file
      pn = Pathname.new(file)
      pn.parent
      @keyfilegroup = Keyfilegroup.new(pn.parent)
      @linegroup_array = []
      @itemx_array = []
      @itemx_hs = {}
    end

    def parse
      current_linegroup = nil
      File.open(@file) do |f|
        f.each_line do |line|
          line.chomp!
          if line.strip.empty?
            unless current_linegroup.nil?
              @linegroup_array << current_linegroup
              current_linegroup = nil
            end
          else
            current_linegroup = Linegroup.new if current_linegroup.nil?
            current_linegroup.add(line)
          end
        end
      end
    end

    def convert
      @linegroup_array.each do |linegroup|
        itemx = Sshitemx.new(@keyfilegroup)
        linegroup.lines.each do |line|
          if line =~ /^\s*#/
            itemx.add_comment(line)
          else
            itemx.add_line(line)
          end
        end
        @itemx_hs[itemx.name] = itemx
        @itemx_array << itemx
      end
    end

    def adjust_keyfile
      @itemx_array.map do |itemx|
      end
    end

    def list_exactly
      @itemx_array.map do |itemx|
        item = itemx.get("Host")
        if item.nil?
          puts "not found Host"
          p itemx
        else
          puts item.value
        end

        item = itemx.get("IdentityFile")
        if item.nil?
          puts "not found IdentityFile"
        else
          puts item.value
        end
      end
    end

    def list
      @itemx_array.map do |itemx|
        name = itemx.get("Host")&.value
        identifyfile = itemx.get("IdentityFile")&.value
        @keyfilegroup.remove(identifyfile) if identifyfile
      end

      # puts "\n"
      # puts "@keyfilegroup.keyfiles.size=#{@keyfilegroup.keyfiles.size}"
      # @itemx_array.map { |x| puts x.name }
    end

    def identityfiles
      list = @itemx_array.map do |itemx|
        itemx.adjust_keyfile
      end
      list.filter { |file| !file.nil? }.uniq
    end
  end
end

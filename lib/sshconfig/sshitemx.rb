module Sshconfig
  class Sshitemx
    attr_reader :name, :adjust_keyfile, :item_array, :items, :comments

    def initialize(keyfilegroup)
      @keyfilegroup = keyfilegroup
      @name = nil
      @adjust_keyfile = nil

      @item_array = []
      @items = {}
      @comments = []
    end

    def add_line(line)
      array = line.strip.split(/\s+/)
      item = Sshitem.new(*array)
      @item_array << line
      @items[item.name] = item

      case item.name
      when /^Host/
        @name = item.name
      when /^IdentityFile/
        @adjust_keyfile = @keyfilegroup.relative_path(item.value)
      else
        # do nothing
      end
    end

    def add_comment(comment)
      @comments << comment
    end

    def get(name)
      @items[name]
    end
  end
end

require "hex_extensions/version"

module Hex

  KILOBYTE = 1024
  MEGABYTE = 1024 * KILOBYTE
  GIGABYTE = 1024 * MEGABYTE

  def assert(desc = nil, &block)
    fail "assertion failed #{desc}\n #{Kernel.caller}" unless block.call
  end
  module_function :assert

  def deep_copy(o)
    Marshal.load(Marshal.dump(o))
  end
  module_function :deep_copy

  def parse_range(str)
      return case str
        when/\A(\d+)\.\.(\d+)\Z/ then ($1.to_i..$2.to_i)
        when/\A(\d+)\.\.\.(\d+)\Z/ then ($1.to_i...$2.to_i)
        else raise "invalid range #{range_str}"
      end
  end
  module_function :parse_range

  def range_intersection(rangea,rangeb)
      assert { rangeb.class == Range }
      assert { rangea.class == Range }
      assert { rangeb.min }
      assert { rangea.min }
      res = ( [rangea.min, rangeb.min].max .. [rangea.max, rangeb.max].min )
      return nil if res.first > res.last
      res
  end
  module_function :range_intersection

  def range_contains?(bigger,smaller)
    bigger.min <= smaller.min && bigger.max >= smaller.max
  end
  module_function :range_contains?

  def range_hex_inspect(range)
    "(#{range.min.to_s(16)}..#{range.max.to_s(16)})"
  end
  module_function :range_hex_inspect

  def hash_map_keys(hash, &block)
    hash.each_pair.reduce({}) { |h, (key, val)| new_key = block.call(key, val); h[new_key] = val; h }
  end
  module_function :hash_map_keys

  def hash_map_values(hash, &block)
    hash.each_pair.reduce({}) { |h, (key, val)| h[key] = block.call(key, val); h }
  end
  module_function :hash_map_values

  def hash_map_pairs(hash, &block)
    hash.each_pair.reduce({}) { |h, (key, val)| new_key, new_val = block.call(key, val); h[new_key] = new_val; h }
  end
  module_function :hash_map_pairs

  def hash_flatten(hash)
    res = {}
    each_pair do |key, val|
      if val.is_a? Hash
        res.merge! hash_flatten_hash
      else
        res[key] = val
      end
    end
    res
  end
  module_function :hash_flatten

end

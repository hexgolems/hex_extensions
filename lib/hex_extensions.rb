require "hex_extensions/version"

module HexExtensions

  def assert(desc = nil, &block)
    fail "assertion failed #{desc}\n #{Kernel.caller}" unless block.call
  end

  def deep_copy(o)
    Marshal.load(Marshal.dump(o))
  end

  def range_intersection(rangea,rangeb)
      assert { rangeb.class == Range }
      assert { rangea.class == Range }
      assert { rangeb.min }
      assert { rangea.min }
      res = ( [rangea.min, rangeb.min].max .. [rangea.max, rangeb.max].min )
      return nil if res.first > res.last
      res
  end

  def range_contains?(bigger,smaller)
    bigger.min <= smaller.min && bigger.max >= smaller.max
  end

  def range_hex_inspect(range)
    "(#{range.min.to_s(16)}..#{range.max.to_s(16)})"
  end

  def hash_map_keys(hash, &block)
    hash.each_pair.reduce({}) { |h, (key, val)| new_key = block.call(key, val); h[new_key] = val; h }
  end

  def hash_map_values(hash, &block)
    hash.each_pair.reduce({}) { |h, (key, val)| h[key] = block.call(key, val); h }
  end

  def hash_map_pairs(hash, &block)
    hash.each_pair.reduce({}) { |h, (key, val)| new_key, new_val = block.call(key, val); h[new_key] = new_val; h }
  end

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

end

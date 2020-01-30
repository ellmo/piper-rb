class Hash

  unless instance_methods.include? :symbolize_keys
    def symbolize_keys
      each_with_object({}) do |(key, val), hash|
        hash[key.to_sym] = val
        hash
      end
    end
  end

end

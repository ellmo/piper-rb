class String
  def servicify
    snaked_self = snakify
    return snaked_self if snaked_self.end_with?("_service")

    snaked_self << "_service"
  end

  def camelify(classify = false)
    if classify
      capitalize
        .gsub(%r{\/(\w)}) { "::" << Regexp.last_match(1).upcase }
        .gsub(/_(\w)/)    { Regexp.last_match(1).upcase }
    else
      split("_").collect(&:capitalize).join
    end
  end

  def snakify
    gsub(/:{1,2}/, "/")
      .gsub(/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
      .gsub(/([a-z\d])([A-Z])/, "\\1_\\2")
      .tr("-", "_")
      .downcase
  end
end

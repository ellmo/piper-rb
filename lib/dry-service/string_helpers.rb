class String
  def servicify
    snaked_self = snakify
    return snaked_self if snaked_self.end_with?("_service")

    snaked_self << "_service"
  end

  def camelify
    split("_").collect(&:capitalize).join
  end

  def snakify
    gsub(/::/, "/")
      .gsub(/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
      .gsub(/([a-z\d])([A-Z])/, "\\1_\\2")
      .tr("-", "_")
      .downcase
  end
end

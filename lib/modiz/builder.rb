class Builder
  def self.run arg
    new(arg).to_hash
  end
end

require 'yaml'
module Serialize
  def to_yaml
    inst_vars = {}
    self.instance_variables.each do |var|
      inst_vars[var] = self.instance_variable_get var
    end
    inst_vars.to_yaml
  end

  def from_yaml!(saved_game)
    YAML.load(saved_game).each do |var, val|
      self.instance_variable_set var, val
    end
  end
end
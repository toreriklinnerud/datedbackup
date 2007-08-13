
require File.dirname(__FILE__) + "/../vendor/plugins/rspec/rspec/lib/autotest/rspec"

class Autotest::Datedbackup < Autotest::Rspec
  alias :old_spec_commands :spec_commands
  
  def spec_commands
    [File.dirname(__FILE__) + "/../vendor/plugins/rspec/rspec/bin/spec"] + old_spec_commands
  end
end

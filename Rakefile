# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'rails_framework_diff'

task :default => 'spec:run'

PROJ.name = 'rails_framework_diff'
PROJ.authors = 'Brian Doll'
PROJ.email = 'brian@emphaticsolutions.com'
PROJ.url = 'http://github.com/briandoll'
PROJ.rubyforge.name = 'rails_framework_diff'

PROJ.spec.opts << '--color'

# EOF

require "universal/engine"
require "universal/extensions"
require "universal/configuration"
Gem.find_files("universal/models/*.rb").each { |path| require path }
Gem.find_files("../app/models/universal/concerns/*.rb").each { |path| require path }

module Universal

end

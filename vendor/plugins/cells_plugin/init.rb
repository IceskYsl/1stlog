#  Copyright (c) 2007-2008 Nick Sutterer <nick@tesbo.com>
#  Copyright (c) 2007-2008 Solide ICT by Peter Bex <peter.bex@solide-ict.nl>
#   Some portions and ideas stolen ruthlessly
#   from Ezra Zygmuntowicz <ezmobius@gmail.com>
#
#  The MIT License
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
#

require 'cell'
require 'cell_extensions'
require 'action_view_extensions'

# Add the code path of 'cells' to the default paths of a Plugin.  This
# gets copied to the list of paths of the Plugin when it's instantiated,
# so be sure to load the Cells Plugin before loading any Plugins that
# have a 'cells' directory, or it will not work.
if Object.const_defined?(:Engines)
  Plugin.class_eval do
    def default_code_paths
      %w(app/controllers app/helpers app/cells app/models components lib)
    end
  end
end

# load application cells not defined in a plugin:
#$LOAD_PATH << RAILS_ROOT+"/app/cells"
Dependencies.load_paths << RAILS_ROOT+"/app/cells"

ActionController::Base.class_eval do
  include Cell::ControllerMethods
end

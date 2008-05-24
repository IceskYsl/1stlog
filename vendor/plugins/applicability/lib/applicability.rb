# Copyright 2007 New Medio.  This file is part of Applicability.  See README for additional information.                          
# TODO:
#  * Allow multiple area tags to be active at once
#  * Implement the remaining applicability controls
#  * Make this work with turning on/off table rows
#

module Applicability
	# This is a simple class which adapts the context class into the <tt>.rhtml</tt> file.
	module ApplicabilityHelper
		# This begins an applicability block.  The block is passed a single variable, which is
		# the "applicability context".  This function can take one parameter, which is the default
		# applicability area tag to activate.  This automatically handles outputting the javascript for you
		# at the end of the block.
		def applicability_begin(default = nil, &block)
			apc = ApplicabilityContext.new(default)
			if block_given?
				yield(apc)
				concat(apc.output_applicability_function, block.binding) 
			end

			return apc
		end
	end

	# This is the main context class.  You rarely instantiate this yourself - it is almost always
	# done through applicability_begin.
	class ApplicabilityContext
		include ActionView::Helpers::FormOptionsHelper
		include ActionView::Helpers::FormTagHelper
		include ActionView::Helpers::TagHelper
		include ActionView::Helpers::JavascriptHelper
		include ActionView::Helpers::TextHelper

		@@id_num = 1

		# Takes one optional parameter - the area tag to activate by default.
		def initialize(default_area = nil)
			@areas = []
			@function_name = "#{idgen}_func"
			@default_area = default_area
		end

		# NOT YET IMPLEMENTED - will work like select_tag, but with the semantics of select
		def select
		end

		# NOT FINISHED/TESTED - this will link to an area tag to activate.
		def link_to(name, tag, *args)
			link_to_function(name, "document.#{@function_name}('#{args[0]}');", args)
		end

		# This is the main tag used to control the active area tag.  Takes several parameters:
		# [name] This is the HTML name for the select tag
		# [option_list] This is a list of options like what would be given to <tt>options_for_select</tt>.  
		#                 HOWEVER, these options take a middle parameter, where the middle parameter is the 
		#                 name of the area which should be shown if the option is selected. 
		# [options] This is just like the options for the regular <tt>select_tag</tt> function, except that
		#             it includes another option, <tt>:default</tt>, which is the default value for the select.
		#
		# If your <tt>option_list</tt> 
		# is <tt>[ ["Option One", :option_one, "one"], ["Option Two", :option_two, "two"]]</tt>, then if you 
		# select "Option One", that will set <tt>:option_one</tt> as the active area tag, and the value passed 
		# in the form will be "one".
		#
		def select_tag(name, option_list, options = {})
			statements = option_list.map{|opt| "if(elem.options[elem.selectedIndex].value == '#{opt.last}') { document.#{@function_name}('#{opt[1]}'); }"}
			selection_function_name = "#{idgen}_func"
			selection_function = "document.#{selection_function_name} = function(elem) { #{statements.join("\n")} };"
                        onchange_action = "#{selection_function_name}(this); #{options[:onchange]}"
			super(name, options_for_select(option_list, options.delete(:default)), options.merge(:onchange => onchange_action)) + javascript_tag(selection_function)
		end

		# NOT IMPLEMENTED - this will allow you to enable multiple areas
		def check_box
		end

		# NOT IMPLEMENTED - this will allow you to enable multiple areas
		def check_box_tag
		end

		# This function creates areas that are turned on and off by the select, checkbox, and link functions.
		# The parameters are:
		# [area_type] This is usually either <tt>:span</tt> or <tt>:div</tt>.  It treats everything except <tt>:span</tt> as a block-level element.  Soon we will get it to work with table-stuff, too.
		# [application_list] You can send as many area tags that you want, and if any of them are selected, this area will be active.  Note that this does not take a list, but instead just pass them each individually.
		#
		# See the README for an example of how to use this in an <tt>.rhtml</tt> file.
		#
		def applies_to(area_type, *application_list, &block)
			area_id = idgen

			area_display_type = area_type == :span ? "inline" : "block"
			@areas.push({ :applicabilities => application_list, :type => area_type, :id => area_id, :display => area_display_type })

			current_display = application_list.include?(@default_area) ? area_display_type : "none"

			content1 = "<#{area_type} id='#{area_id}' style='display: #{current_display};'>"
			content2 = "</#{area_type}>"
			concat(content1, block.binding)
			yield
			concat(content2, block.binding)
		end

		# This is the name of the function that will be used to control the active applicability tag.
		def applicability_function_name
			@function_name
		end

		# This actually generates and spits out the function to control the <tt>applies_to</tt> sections
		# based on the active area tag.  If you use the <tt>applicability_begin</tt> helper, you will
		# never need to use this function.
		def output_applicability_function
			statements = @areas.map do |area| 
				substatements = area[:applicabilities].map do |applic| 
					"if(applic_name == '#{applic}') { should_hide = false; $('#{area[:id]}').style.display = '#{area[:display]}'; }"
				end
				"should_hide = true;\n#{substatements.join("\n")}\nif(should_hide) { $('#{area[:id]}').style.display = 'none'; }"
			end
			javascript_tag("document.#{@function_name} = function(applic_name) { #{statements.join("\n\n")} };")
		end

		private
		def idgen
			@@id_num += 1
			"reach_applic_#{@@id_num}"
		end

	end
end

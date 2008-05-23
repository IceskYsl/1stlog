# Extending <tt>ActionView::Base</tt> to support rendering themes
#
module ActionView
  STDERR.puts "init ActionView..."
  # Extending <tt>ActionView::Base</tt> to support rendering themes
  class Base
    STDERR.puts "start init ActionView Base..."
    alias_method :__render_file, :render_file
    
    
    
    # Overrides the default Base#render_file to allow theme-specific views
    def render_file(template_path, use_full_path = true, local_assigns = {})
      search_path = [
        "../themes/#{controller.current_theme}/views",       # for components
        "../../themes/#{controller.current_theme}/views",    # for normal views
        "../../themes/#{controller.current_theme}",          # for layouts
        "../../../themes/#{controller.current_theme}/views", # for mailer views
        ".",                                                 # fallback
        ".."                                                 # Mailer fallback
      ]
      if use_full_path
        template_path_without_extension, template_extension = path_and_extension(template_path)
        template_extension = pick_template_extension(template_path).to_s if !template_extension
        local_assigns['active_theme'] = get_current_theme(local_assigns)
        search_path.each do |prefix|
          begin
            # template_extension = pick_template_extension(theme_path)
            if File.exists?(full_template_path("#{prefix}/#{template_path_without_extension}", template_extension))
              # Prevent .rhtml (or any other template type) if force_liquid == true
              raise ThemeError.new("Template '#{template_path}' must be a liquid document") if force_liquid? && template_extension.to_s != 'liquid' && prefix != '.'                  
              return __render_file("#{prefix}/#{template_path}", use_full_path, local_assigns)
            end
            #rescue ActionView::ActionViewError => err
            #   next
          rescue ThemeError => err
            # Should it raise an exception, or just call 'next' and revert to
            # the default template?
            raise err
          end
        end
        raise ActionViewError, "No rhtml, rxml, or delegate template found for #{template_path}"
      else
        __render_file(template_path, use_full_path, local_assigns)
      end
    end

    #    # Overrides the default <tt>Base#render_file</tt> to allow theme-specific views
    #    def render_file(template_path, use_full_path = true, local_assigns = {})
    #      logger.info "\n================================================\ninit ActionView Base render_file..."
    #      
    #      search_path = [
    ##        "../themes/#{controller.current_theme}/views",       # for components
    ##        "../../themes/#{controller.current_theme}/views",    # for normal views
    #        "../../themes/#{controller.current_theme}",          # for layouts
    #        "../../../themes/#{controller.current_theme}/views", # for mailer views
    #        "",
    #        "../",                                                 # fallback
    #        "../../"                                                 # Mailer fallback
    #      ]
    #      logger.info "template_path=#{template_path},use_full_path=#{use_full_path},search_path=> #{search_path.join(',')}"
    #      
    #      if use_full_path
    #        search_path.each do |prefix|
    #          theme_path = prefix +'/'+ template_path
    #          logger.info("\ntheme_path=#{theme_path}\n")
    #          begin
    #            template_path_without_extension, template_extension = path_and_extension(theme_path)
    #            template_extension = pick_template_extension(theme_path).to_s if !template_extension
    #
    ##            template_extension = pick_template_extension(theme_path)
    #            logger.info("\ntemplate_path_without_extension=#{template_path_without_extension},template_extension=#{template_extension}\n")
    #
    #            # Prevent .rhtml (or any other template type) if force_liquid == true
    #            if force_liquid? and
    #                template_extension.to_s != 'liquid' and 
    #                prefix != '.'
    #              raise ThemeError.new("Template '#{template_path}' must be a liquid document")
    #            end
    #                  
    #            local_assigns['active_theme'] = get_current_theme(local_assigns)
    #          rescue ActionView::TemplateError => err
    #            logger.info "ActionView::TemplateError=> #{$!}"
    #            next if err.message =~ /No such file or directory/            # for rxml templates
    #            raise err
    #          rescue ActionView::ActionViewError => err
    #            logger.info "ActionView::ActionViewError=> #{$!}"
    #            next
    #          rescue ThemeError => err
    #            # Should it raise an exception, or just call 'next' and revert to
    #            # the default template?
    #            logger.info "ThemeError=> #{$!}"
    #            raise err
    #          end
    #          return __render_file(theme_path, use_full_path, local_assigns)
    #        end
    #        raise ActionViewError, "No rhtml, rxml, or delegate template found for #{template_path}"
    #      else
    #        __render_file(template_path, use_full_path, local_assigns)
    #      end
    #    end
      
    private
   
    def force_liquid?
      unless controller.nil?
        if controller.respond_to?('force_liquid_template')
          controller.force_liquid_template
        end
      else
        false
      end
    end

    def get_current_theme(local_assigns)
      unless controller.nil?
        if controller.respond_to?('current_theme')
          return controller.current_theme || false
        end
      end
      # Used with ActionMailers
      if local_assigns.include? :current_theme 
        return local_assigns.delete :current_theme
      end
    end
    
  end
  STDERR.puts "end ActionView Base render_file..."
end

 module ActionView  
   module Helpers  
     module TextHelper  
       ALLOWED_TAGS = %w(a img) unless defined?(ALLOWED_TAGS)  
   
       def whitelist(html)  
          #only do this if absolutely necessary  
         if html.index("<")  
           tokenizer = HTML::Tokenizer.new(html)  
           new_text = ""  
   
           while token = tokenizer.next  
             node = HTML::Node.parse(nil, 0, 0, token, false)  
             new_text << case node  
                         when HTML::Tag  
                           if ALLOWED_TAGS.include?(node.name)  
                             node.to_s  
                           else  
                             node.to_s.gsub(/</, "LT")  
                           end  
                         else  
                           node.to_s.gsub(/</, "LT")  
                         end  
           end  
   
           html = new_text  
         end  
         html  
       end  
     end  
   end  
 end 
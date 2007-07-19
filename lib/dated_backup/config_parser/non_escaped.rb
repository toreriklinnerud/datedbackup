
class Object
  def metaclass
    class << self; self; end
  end
end

class Array
  
  def firsts
    l = []
    
    self.each do |obj|
      if obj.respond_to? :first
        l += obj.first
      else
        l += obj
      end
    end
  end
end

class DatedBackup
  class DSL
    class Base
      
      module UtilityFunctions
        # split by escaped data and non-escaped data
        # and for each non-escaped_data, yield that data
        # finally, rebuild the entire string, with the rules from
        # the escaped and non-escaped data in their original order
        def non_escaped_data(data)
          filter(data, regexps[:non_escaped], true) do |non_escaped|
            yield non_escaped
          end
        end      
          
            # TODO: CLEAN THIS UP & ABSTRACT IT

            # would have used def for the methods, 
            # and class << modified;....; end, but needed
            # a closure to get to scanned, original, and data variables

            # this is in general a bad technique for two reasons:
            # 1. every method that needs to be changed will need to be changed here
            #    (i.e., this part needs to be abstracted, and done cleanly)
            # 2. side affects are only present when calling the non-escaped section
            #    of @parsed_data.  if @parsed_data changes, so should the section
            #    of @parsed_data (which is usually the non-escaped section of that)
            #    string
      
        def filter(data, pattern, negation=false)
          #if negation 
          #  scanned_data = data.split(pattern)
          #else
            scanned_data = data.scan(pattern).join.to_a
            scanned_data = [data] if scanned_data.nil? || scanned_data.empty?
          #end

          scanned_data.each do |array|
            original = array
            modified = original.dup

            create_side_effects_for modified, :affecting => data,
                                              :with => original
            #create_side_effects_for data,     :affecting => modified,
                                              #:with => data.dup
            yield modified
          end        
        end
      
        def filter_keys(data, h)
          raise "Must filter keys either with or without spaces" if h[:with_spaces].nil?
          regex = h[:with_spaces] ? regexps[:key_with_spaces] : regexps[:keys]
          
          filter(data, regex) do |key|
            yield key
          end          
        end
      
        def filter_values(data, h)
          raise "Must filter keys either with or without spaces" if h[:with_spaces].nil?
          
          regex = h[:with_spaces] ? regexps[:values] : regexps[:values]
        
          filter(data, regexps[:values]) do |value|
            yield value
          end
        end
      
      protected
    
        def create_side_effects_for(modified, h={})
          original, whole_data_set = h[:with], h[:affecting]

          modified.metaclass.class_eval do
            alias_method :old_gsub!, :gsub!
            alias_method :old_strip!, :strip!

            instance_eval do
          
              define_method :strip! do 
                modified.old_strip!
                whole_data_set.gsub! original, modified
              end
          
              define_method :gsub! do |search, replace|
                modified.old_gsub! search, replace
                whole_data_set.gsub! original, modified
              end
            end
          end
        end
      end
      
    end  
  end
end
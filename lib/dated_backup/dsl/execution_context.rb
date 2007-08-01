
module DatedBackup
  class ExecutionContext

    def initialize(name, *params, &blk)  
      DatedBackup::Warnings.execute_silently do
        if name == :main
          params.each do |filename|
            Main.load filename
          end
        elsif name == :before || name == :after
          Around.new &blk
        end        
      end
    end
    
    class Main
      class << self
        def load(filename)
          klass = Class.new
          klass.send(:include, DSL::Main)
          instance = klass.new          
          
          File.open filename, "r" do |file|
            instance.instance_eval file.read
          end
          
          @main_instance = DatedBackup::Core.new(instance.procs)
          @main_instance.set_attributes(instance.hash)
          @main_instance.run
        end
        
        attr_reader :main_instance
        alias :core_instance :main_instance
        alias :instance      :main_instance
      end
    end

    class Around
      def initialize(around=self, &blk)
        around.instance_eval &blk
      end

      def remove_old(&blk)
        klass = Class.new
        klass.send(:include, DSL::TimeExtensions)
        instance = klass.new

        instance.instance_eval &blk
        
        Core::BackupRemover.remove!(Main.instance.backup_root, instance.kept)
      end
    end
  
  end
end

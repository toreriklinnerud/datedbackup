
module DatedBackup 
  class Core

    unless const_defined?("BACKUP_REGEXP")
      BACKUP_REGEXP = /[12][0-9]{3}\-[01][0-9]\-[0-3][0-9]\-[0-2][0-9]h\-[0-6][0-9]m\-[0-6][0-9]s/ 
    end

    include DatedBackup::Core::CommandLine
    include DatedBackup::Core::Tasks

    attr_accessor :sources, :destination, :options, :backup_root, :user_domain
    attr_reader :pre_run_commands, :kernel
    attr_reader :before_run, :after_run

    def initialize(procs={}, kernel=Kernel)
      @kernel = kernel
      @before_run = procs[:before] || Proc.new {}
      @after_run = procs[:after] || Proc.new {}
    end

    def set_attributes(h={})
      parse_command_options(h)
      @destination = generate_backup_filename    
      if @user_domain
        @sources.map! { |src| "#{@user_domain}:#{src}" }
      end        
    end

    def check_for_directory_errors
      if sources.nil? || sources.empty?
        raise DirectoryError, "No source directory given"
      elsif backup_root.nil? || backup_root.empty?
        raise DirectoryError, "No destination directory given"
      end
    end

    # create the first backup, if non-existent  
    # otherwise cp -al (or # replace cp -al a b with cd a && find . -print | cpio -dpl ../b )
    # and then create the backup of the dirs using rsync -a --delete
    # the files, in the end, should be read only and undeletable
    def run
      DatedBackup::ExecutionContext.new :before, &@before_run
      run_tasks
      DatedBackup::ExecutionContext.new :after, &@after_run
    end

  private

    def generate_backup_filename
      "#{@backup_root}/#{Time.now.to_string}"
    end                         

    def parse_command_options(h={})
      @pre_run_commands = h[:pre_run_commands]
      @pre_run_commands = h[:pre_run_command].to_a if h[:pre_run_command]

      @backup_root = *h[:destination]
      @options = h[:options] ? h[:options].map { |e| "#{e} "}.to_s.strip : ""

      @user_domain = h[:user_domain]    
      @sources = h[:sources] || h[:source]
      check_for_directory_errors
    end

  end
    
end   



files = ["bin/dbackup", "lib/dated_backup", "lib/dated_backup/core", "lib/dated_backup/core/backup_remover.rb", "lib/dated_backup/core/backup_set.rb", "lib/dated_backup/core/command_line.rb", "lib/dated_backup/core/dated_backup.rb", "lib/dated_backup/core/tasks.rb", "lib/dated_backup/core/version.rb", "lib/dated_backup/core/warnings.rb", "lib/dated_backup/core.rb", "lib/dated_backup/dsl", "lib/dated_backup/dsl/execution_context.rb", "lib/dated_backup/dsl/main.rb", "lib/dated_backup/dsl/time_extensions.rb", "lib/dated_backup/dsl.rb", "lib/dated_backup/extensions", "lib/dated_backup/extensions/array.rb", "lib/dated_backup/extensions/error.rb", "lib/dated_backup/extensions/reverse_sorted_unique_array.rb", "lib/dated_backup/extensions/string.rb", "lib/dated_backup/extensions/time.rb", "lib/dated_backup/extensions/time_symbol.rb", "lib/dated_backup/extensions.rb", "lib/dated_backup.rb", "example_configs/example.com", "example_configs/local_etc_backup", "example_configs/samba_shares"]
extra_files = %w(README MIT-LICENSE GPL-LICENSE RELEASES CHANGELOG)

Gem::Specification.new do |s| 
  s.name      = "dated_backup"
  s.version   = "0.2.3"
  s.author    = "Scott Taylor"
  s.email     = "scott@railsnewbie.com"
  s.homepage  = "http://rubyforge.org/projects/datedbackup"
  s.platform  = Gem::Platform::RUBY
  s.summary   = "Incremental Dated Backups Using Rsync"
  s.files     = files + extra_files
              
  s.bindir   = 'bin'
  s.executables = ["dbackup"]   
  
  s.add_dependency 'activesupport', '= 1.4.2' 
      
  s.has_rdoc          = false
end
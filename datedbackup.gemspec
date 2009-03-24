Gem::Specification.new do |s| 
  s.name      = "dated_backup"
  s.version   = "0.2.1"
  s.author    = "Scott Taylor"
  s.email     = "scott@railsnewbie.com"
  s.homepage  = "http://rubyforge.org/projects/datedbackup"
  s.platform  = Gem::Platform::RUBY
  s.summary   = "Incremental Dated Backups Using Rsync"
              
  s.files     = rdoc_files + extra_rdoc_files
  
  s.bindir   = 'bin'
  s.executables = ["dbackup"]   
  
  s.add_dependency 'activesupport', '= 1.4.2' 
      
  s.has_rdoc          = false
end
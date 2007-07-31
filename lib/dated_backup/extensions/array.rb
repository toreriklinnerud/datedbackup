
class Array
  def car
    first
  end
  
  def cdr
    self.[](1..self.length)
  end
  
  def to_backup_set
    DatedBackup::Core::BackupSet.new(self)
  end
end

# A subclass of Array, but it calls uniq!, sort!, and reverse!
# (in that order) after the instance is created
class ReverseSortedUniqueArray < Array
  
  def initialize *args, &blk
    super *args, &blk
    uniq!
    sort!
    reverse!
  end    
  
end

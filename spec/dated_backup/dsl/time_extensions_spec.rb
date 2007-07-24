require File.dirname(__FILE__) + "/../../spec_helper"


describe "A method which has an equivalent plural alias", :shared => true do
  it "should respond to the plural version" do
    @extension.should respond_to("#{@method_name}s".to_sym)
  end
  
  it "should equal the same value as the singular form" do
    @extension.send("#{@method_name}s".to_sym).should == @extension.send(@method_name)
  end
end

describe "A method which returns self", :shared => true do
  it "should return self" do
    @extension.send(@method_name, nil).should == @extension
  end
end

describe "A method which is responded to", :shared => true do
  it do
    @extension.should respond_to(@method_name)
  end
end


describe DatedBackup::DirectoryTimeExtensions, "backup" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :backup
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
  it_should_behave_like "A method which has an equivalent plural alias"
end

describe DatedBackup::DirectoryTimeExtensions, "other" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :backup
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
  it_should_behave_like "A method which has an equivalent plural alias"
end

describe DatedBackup::DirectoryTimeExtensions, "week" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :week
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
  it_should_behave_like "A method which has an equivalent plural alias"

  it "should set the last time value to a the :week symbol" do
    @extension.week
    @extension.last_time.should == :week
  end  
end

describe DatedBackup::DirectoryTimeExtensions, "day" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :day
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
  it_should_behave_like "A method which has an equivalent plural alias"
  
  it "should set the last time value to :day" do
    @extension.day
    @extension.last_time.should == :day
  end
end

describe DatedBackup::DirectoryTimeExtensions, "months" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :month
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
  it_should_behave_like "A method which has an equivalent plural alias"
  
  it "should set the last time value to :month" do
    @extension.month
    @extension.last_time.should == :month
  end
end

describe DatedBackup::DirectoryTimeExtensions, "year" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :year
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"  
  it_should_behave_like "A method which has an equivalent plural alias"
  
  it "should set the last time value to :year" do
    @extension.year
    @extension.last_time.should == :year
  end
end

describe DatedBackup::DirectoryTimeExtensions, "keeping" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @t = Time.now
    @time_range = @t.at_beginning_of_week...@t
    @method_name = :keep
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
  
  it "should append the current time_range hash unto the array it has build" do
    @extension.instance_variable_set("@time_range", {:constraint => @time_range})
    @extension.time_range.should == {:constraint => @time_range}
    
    @extension.kept.should == []
    @extension.keep(@extension.week, @t)
    @extension.kept.should == [{:constraint => @time_range}]
  end
  
  it "should return the TimeRange array to it\'s initial state" do
    @extension.instance_variable_set("@time_range", {:constraint => @time_range})
    @extension.time_range.should == {:constraint => @time_range}
        
    @extension.keep(@extension.week, @t)
    @extension.time_range.should == []
  end
  
  it "should return the last_time to it\'s initial state" do
    @extension.instance_variable_set("@time_range", {:constraint => @time_range})
    @extension.time_range.should == {:constraint => @time_range}
    
    @extension.keep(@extension.week, @t)
    @extension.last_time.should == nil
  end
  
  it "should apply the :all constraint if no other constraint is present" do
    @extension.instance_variable_set("@time_range", Hash.new)
    @extension.time_range.should == {}
    @extension.keep(nil, @t)
    @extension.kept.should == [{:constraint => Time.epoch...@t}]
  end
end

describe DatedBackup::DirectoryTimeExtensions, "this" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @t = Time.now
    @method_name = :this
  end
  
  it "should return self" do
    @extension.this(@extension.week, @t).should == @extension
  end

  it_should_behave_like "A method which is responded to"  
  
  it "should add this week to the time_range array with a :constraint => timerange hash" do
    @time_range = @t.at_beginning_of_week...@t
    @extension.this(@extension.week, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
  
  it "should add this day to the time_range array with a :constraint => timerange hash" do
    @time_range = @t.at_beginning_of_day...@t
    @extension.this(@extension.day, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
  
  it "should add this month to the time_range array with a :constraint => timerange hash" do
    @time_range = @t.at_beginning_of_month...@t
    @extension.this(@extension.month, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
  
  it "should add this year to the time_range array with a :constraint => timerange hash" do
    @time_range = @t.at_beginning_of_year...@t
    @extension.this(@extension.year, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
end


describe DatedBackup::DirectoryTimeExtensions, "last" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @t = Time.now
    @method_name = :last
  end
  
  it "should return self" do
    @extension.last(@extension.week, @t).should == @extension
  end
  
  it_should_behave_like "A method which is responded to"  
  
  it "should add the last week to the time_range array in a :constraint => timerange hash" do
    @time_range = @t.last_week.beginning_of_week...@t.last_week.end_of_week
    @extension.last(@extension.week, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
  
  it "should add the last day to the time_range array in a :constraint => timerange hash" do
    @time_range = @t.yesterday.at_beginning_of_day...@t.yesterday.end_of_day
    @extension.last(@extension.day, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
  
  it "should add the last month to the time_range array in a :constraint => timerange hash" do
    @time_range = @t.last_month.at_beginning_of_month...@t.last_month.end_of_month
    @extension.last(@extension.month, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
  
  it "should add the last year to the time_range array in a :constraint => timerange hash" do
    @time_range = @t.last_year.at_beginning_of_year...@t.last_year.end_of_year
    @extension.last(@extension.year, @t)
    @extension.time_range.should == {:constraint => @time_range}
  end
end

describe DatedBackup::DirectoryTimeExtensions, "the *ly methods" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
  end
  
  it "should add type => :daily unto the time_range hash" do
    @extension.time_range.should == {}
    @extension.daily
    @extension.time_range.should == {:type => :daily}
  end
  
  it "should add type => :weekly unto the time_range hash" do
    @extension.time_range.should == {}
    @extension.weekly
    @extension.time_range.should == {:type => :weekly}
  end
  
  it "should add type => :monthly unto the time_range hash" do
    @extension.time_range.should == {}
    @extension.monthly
    @extension.time_range.should == {:type => :monthly}
  end
  
  it "should add type => :yearly unto the time_range hash" do
    @extension.time_range.should == {}
    @extension.yearly
    @extension.time_range.should == {:type => :yearly}
  end
end

describe DatedBackup::DirectoryTimeExtensions, "from" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :from
  end
  
  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
end

describe DatedBackup::DirectoryTimeExtensions, "all" do
  before :each do
    @extension = DatedBackup::DirectoryTimeExtensions.new
    @method_name = :all
    @t = Time.now
  end

  it_should_behave_like "A method which returns self"
  it_should_behave_like "A method which is responded to"
  
  it "should set the constrait from Jan 1970 to now" do
    @extension.all(nil, @t)
    @extension.time_range.should == {:constraint => Time.epoch...@t}
  end
end
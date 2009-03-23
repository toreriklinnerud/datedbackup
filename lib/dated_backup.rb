# DatedBackup, A snapshot backup utility
# Copyright (C) Scott Taylor (scott@railsnewbie.com), 2007

require 'rubygems'

gem 'activesupport', '=1.4.2'

require File.dirname(__FILE__) + "/dated_backup/extensions"
require File.dirname(__FILE__) + "/dated_backup/dsl"
require File.dirname(__FILE__) + "/dated_backup/core"

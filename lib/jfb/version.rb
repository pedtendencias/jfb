module Jfb
  VERSION = "0.5.0"

#What the numbers mean: rr.ff.hh
# rr: Major releases and changes in the project;
# ff: Features added
# hh: Hotfixes in the project

#Version 0.1.0
# Creates proper interface with jdbc
# creates interface for ResultSet Class
# Handles exceptions and drivers

#Version 0.1.1
# Adds dependency which I had forgot.

#Version 0.1.2
# Adds jdbc/firebird text to JDBC Connection.

#Version 0.1.3
# Adds ResultSet class import for jfb

#Version 0.2.3
# Removes jdbc/firebird dependency
# Adds jaybird version 2.2.10 to gem
# Makes connection idependent from standard java.sql, as to prevent 'no suitable driver' related errors
# Better handling and detection plausible connections

#Version 0.2.4
# Fixup at the require of the jarfile

#Version 0.2.5
# Forgot a new in FBDrivers's invocation

#Version 0.2.6
# Fix typos at method calls

#Version 0.2.7
# Proper Exception handling for query/update.

#Version 0.2.8
# Removed Exception class unnecessary importation to prevent warnings.

#Version 0.2.9
# Adds commit function.

#Version 0.3.9
# Improves error reporting.

#Version 0.4.9
# Adds interface for connection status because who would imagine that this would be important? (me, I should have)
# Updates Jaybird to 2.2.14

#Version 0.4.10
# Uses Jaybird-full file

#Version 0.4.11
# Rollback Jaybird version to 2.2.12

#Version 0.5.0
# Implements standard rs to matrix conversion
end

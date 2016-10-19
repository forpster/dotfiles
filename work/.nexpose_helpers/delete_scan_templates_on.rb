require 'nexpose'
include Nexpose
nsc = Connection.new(ARGV[0], 'nxadmin', 'nxadmin')
nsc.login
print "Finding and deleting all scan templates created by Cucumber..."
i = 0
nsc.scan_templates.each do |template|
  next unless template.id.include? 'cucumber'
  nsc.delete_scan_template(template.id)
  i += 1
end
print "done! (Deleted #{i} templates)\n"

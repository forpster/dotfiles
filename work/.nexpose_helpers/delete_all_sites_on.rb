require 'nexpose'
include Nexpose
nsc = Connection.new(ARGV[0], 'nxadmin', 'nxadmin')
nsc.login
all_sites = nsc.sites
site_count = all_sites.length
i = 0
nsc.sites.each do |site|
  i += 1
  print "Deleting site #{i}/#{site_count}\r"
  nsc.delete_site(site.id)
end
print "\n"

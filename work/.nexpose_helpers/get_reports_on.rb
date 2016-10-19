require 'nexpose'
include Nexpose
nsc = Connection.new(ARGV[0], 'nxadmin', 'nxadmin')
nsc.login
print "Fetching reports from #{ARGV[0]}\n"
all_reports = nsc.reports
print "\n"
print "| ID | NAME | TYPE |\n"
all_reports.each do |report|
  print "| #{report.config_id} | #{report.name} | #{report.template_id} |\n"
end
print "\n"
print "Select a report id: "
report_id = STDIN.gets.chomp.to_i
print "\n"
report_content = nil
all_reports.each do |report|
  next unless report.config_id == report_id
  print "Downloading report..."
  sleep 1
  report_content = nsc.download(report.uri)
  print "done!\n"
  file_name = report.name.gsub(/[:.\s\/]/, '_') + '_' + nsc.host.gsub(/[:.\s\/]/, '_')
  File.open('/tmp/' + file_name, 'w') { |file| file.write(report_content) }
  print "File written to /tmp/#{file_name}\n"
end

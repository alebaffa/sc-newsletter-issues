#/usr/bin/env ruby
#
require 'uri'

def check_lines (url)
	Dir.foreach(".") do |file_name|
	  if /-published/.match(file_name)
		File.open(file_name) do |f|
	      f.each_line do |line|
	          if line.include? url
	          	puts "Found #{url} in #{file_name}"
	          	raise ArgumentError, "Duplicate Error!", url
	          	break
	          end
	      end
		end	
		end
	end	
end

files_open = Dir.glob("*-open.md")
files_open.each do |file_open|
	File.open(file_open) do |f|
	  f.each_line do |line|
	  	if line.start_with?("*")
	  		url = URI.extract(line, ['http', 'https'])
	  		url.each do |matches|
  				check_lines(matches)
			end
	  	end
	  end
  	end
end




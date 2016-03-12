#/usr/bin/env ruby

require 'uri'

def check_link_in_old_newsletter (url)
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

def check_links_in_open_newsletter
  files_open = Dir.glob("*-open.md")
  files_open.each do |file_open|
    File.open(file_open) do |f|
      f.each_line do |line|
        if line.start_with?("*")
          all_url = URI.extract(line, ['http', 'https'])
          all_url.each do |url|
            check_link_in_old_newsletter(url)
          end
        end
      end
    end
  end
end

check_links_in_open_newsletter

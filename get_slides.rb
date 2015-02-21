#!/usr/bin/ruby

module GetSlides

  require 'net/http'
  require 'fileutils'

  class << self

    # Default asumes (at least for now) that the images are "#{site_url}mgp#{number}.jpg" where number is of the form 00001, 00002
    def get_images(site_url, destination_folder, options = {})
      # Options:
      options = default_options.merge options
      verbose = options[:verbose]
      zero_padding = options[:zero_padding]  # Number padding. i.e, if zero_padding==4, it generates 0001, 0002...
      file_prefix = options[:prefix]
      file_sufixes = options[:sufix]
      file_sufixes = *file_sufixes           # In case it was pased one string, it becomes an Array of sufixes

      slide_num = 1
      keep_downloading = true
      while keep_downloading do
        downloads = file_sufixes.select do |sufix|
          file_name = "#{file_prefix}#{slide_num.to_s.rjust(zero_padding, '0')}#{sufix}"
          download_and_save(site_url, file_name, destination_folder, verbose)
        end
        keep_downloading = downloads.any?
        slide_num += 1 if keep_downloading
      end
      # create index.html as the first slide:
      if slide_num > 1
        puts "Creating index.html" if verbose
        first_slide = "#{file_prefix}#{'1'.rjust(zero_padding, '0')}.html"
        FileUtils.cp "#{destination_folder}#{first_slide}", "#{destination_folder}index.html"
      end
    end

    private

    def default_options
      { verbose: false,
        zero_padding: 5,
        prefix: 'mgp',
        sufix: [ '.html', '.jpg', '.txt' ] }
    end

    def download_and_save(url, file_name, destination_folder, verbose = false)
      file_url = "#{url}#{file_name}"
      file_content = download_file(file_url, verbose) # Get response body (could be binary), return nil if it doesn't exist
      if file_content
        save_file(destination_folder, file_name, file_content, verbose)
        true
      else
        false
      end
    end

    def download_file(url, verbose = false)
      unless url && !url.empty?
        return nil
      end
      puts "Downloading '#{url}'..." if verbose
      uri = URI(url)
      response = Net::HTTP.get_response(uri)
      response.body if response.code == '200'
    end

    def save_file(folder, file_name, content, verbose = false)
      unless file_name
        return nil
      end
      puts "Saving '#{folder}#{file_name}'"
      IO.binwrite "#{folder}#{file_name}", content
    end

  end
end

# Getting params:
site_url = ARGV[0] if ARGV.size > 0
destination_folder = ARGV[1] if ARGV.size > 1
verbose = (ARGV.size > 2 && ARGV[2].downcase == '-v')

# Preparing all, based on the parameters' value:
puts 'Running in Verbose mode' if verbose
if destination_folder && !destination_folder.empty?
  unless Dir.exists? destination_folder
    puts "The destination folder doesn't exist, so we will create it ('#{destination_folder}')" if verbose
    FileUtils.mkdir_p destination_folder
  end
  destination_folder += File::Separator unless destination_folder.end_with?(File::Separator) # File::Separator is usually '/'
end

# If something is missing:
unless site_url && destination_folder
  puts 'There are missing params' unless site_url && destination_folder
  exit false
end

# Download slides:
GetSlides.get_images(site_url, destination_folder, verbose: verbose)

# Maybe next: build HTML pages for slides navigation within the destination_folder

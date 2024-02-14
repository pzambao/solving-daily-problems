require 'fileutils'

script_name = File.basename(__FILE__)

organizer_dir = File.join(File.dirname(__FILE__), 'desktop_organizer')

FileUtils.mkdir(organizer_dir)

desktop_items = Dir[File.join(File.dirname(__FILE__), '*')]

desktop_items.reject! { |item| File.directory?(item) && File.basename(item) == 'desktop_organizer' }
desktop_items.reject! { |item| File.file?(item) && File.basename(item) == script_name }

unless items_on_desktop.empty?
  desktop_items.each do |item|
    modification_date = File.mtime(item)
    date_directory = modification_date.strftime('%d-%m-%y')

    target_directory = File.join(organizer_dir, date_directory)

    FileUtils.mkdir(target_directory)
    FileUtils.mv(item, target_directory)
  end

  puts 'Successfully organized workspace!'
else
  puts 'No files or directories to be organized.'
end

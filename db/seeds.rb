Dir[Rails.root.join('db/seeds/*.rb')].sort.each do |file|
  filename = file.split('/').last
  modelname = filename.split('_').last.delete_suffix('.rb')

  puts "Processing #{modelname} seed..."
  require file
  puts "done ✓"
end
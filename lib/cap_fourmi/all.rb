Dir.glob(File.expand_path(File.join('..', 'tasks', '**', '*.cap'), __FILE__)).each do |cap_file|
  load cap_file
end

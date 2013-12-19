require 'cap_fourmi'
%w(capabilities notifiers).each do |feature|
  Dir.glob(File.expand_path(File.join('..', feature, '**', '*.cap'), __FILE__)).each do |cap_file|
    load cap_file
  end
end
include CapFourmi::Global

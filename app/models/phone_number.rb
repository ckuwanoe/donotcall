class PhoneNumber < ActiveRecord::Base
  require "do_not_call"
  require 'csv'

  def self.do_not_call(phone)
    DoNotCallApi::Client.add_to_do_not_call_list(phone)
  end

  def self.import_csv(file, header=nil, col)
    f = File.new('tmp/import.log', "a")
    header.nil? ? start = 0 : start = 1
    CSV.parse(File.open(file))[start..-1].each do |row|
      self.do_not_call(row[col-1].to_s) if row[col-1].size >= 9
    end
  end
end

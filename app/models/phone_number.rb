class PhoneNumber < ActiveRecord::Base
  require "do_not_call"

  def self.do_not_call(phone)
    DoNotCallApi::Client.add_to_do_not_call_list(phone)
  end
end

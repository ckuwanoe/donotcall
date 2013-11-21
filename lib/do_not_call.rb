require 'rubygems'
require 'mechanize'
require 'open-uri'

module DoNotCallApi
  module Client
    EMAIL = 'foobar' unless defined?(EMAIL)
    def self.add_to_do_not_call_list(phone)
      email = "dnc89123+#{rand(1...99999)}@gmail.com" #set email address using random number after the +
      agent = Mechanize.new
      agent.get("https://donotcall.gov/register/reg.aspx")

      #find the first form and set the variables, then submit
      form = agent.page.forms[0]
      form["ctl00$ContentPlaceHolder1$PhoneNumberTextBox1"] = phone
      form["ctl00$ContentPlaceHolder1$EmailAddressTextBox"] = email
      form["ctl00$ContentPlaceHolder1$ConfirmEmailAddressTextBox"] = email
      form.click_button

      # click the confirm button on confirmation screen
      confirm = agent.page.forms[0]
      confirm.click_button
    end
  end
end

#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require 'mailman'
require 'mechanize'
require 'open-uri'
require 'nokogiri'

require "#{File.dirname __FILE__}/../config/environment"
Mailman.config.ignore_stdin = true

Mailman.config.pop3 = {
  :username => 'dnc89123@gmail.com',
  :password => 'PTthtk7HGLv0sl',
  :server   => 'pop.gmail.com',
  :port     => 995, # defaults to 110
  :ssl      => true # defaults to false
}

Mailman::Application.run do
  from 'register@donotcall.gov' do
    doc = Nokogiri::HTML.parse(message.body.decoded)
    link = doc.search('a').first['href']
    agent = Mechanize.new
    agent.get(link)
    f = File.new("#{Rails.root.to_s}/log/mailman.log", "a")
    f.write "#{Time.zone.now} - clicked link #{link}\n"
    f.close
  end
end



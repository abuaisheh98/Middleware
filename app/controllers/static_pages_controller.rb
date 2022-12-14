class StaticPagesController < ApplicationController
  def home
    require 'redis'

    cash = Redis.new(host: 'localhost')
    email = cash.set('email','laith@gmail.com')
    #store password 10 second
    secret_info = cash.setex('password',10,"123456789")

    puts "==========",email,"==========",secret_info
  end
end

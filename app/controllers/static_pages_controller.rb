class StaticPagesController < ApplicationController
  def home
    require 'redis'

    cash = Redis.new(host: 'localhost')
    email = cash.set('email','laith@gmail.com')
    #store password 10 second
    secret_info = cash.setex('password',10,"123456789")

    cash.zadd('popular',10,'Laith')
    cash.zadd('popular',8,'Ahmmad')
    cash.zadd('popular',15,'Ali')

    puts "==========",email,"==========",secret_info,"============",cash.zrevrange(0,0),"===========",cash.zrevrange(0,-1)
  end
end

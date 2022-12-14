class StaticPagesController < ApplicationController
  def home
    require 'redis'

    cash = Redis.new(host: 'localhost')
    cash.set('email','laith@gmail.com')
    email = cash.get('email')
    #store password 10 second
    cash.setex('password',10,"123456789")
    secret_info = cash.get('password')

    cash.zadd('popular',10,'Laith')
    cash.zadd('popular',8,'Ahmmad')
    cash.zadd('popular',15,'Ali')

    puts "==========",email,"==========",secret_info,"============",cash.zrevrange('popular',0,0),"===========",cash.zrevrange('popular',0,-1)
  end
end

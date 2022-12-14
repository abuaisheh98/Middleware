require 'csv'
class LogMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    user_agent = UserAgent.parse(request.user_agent)

    ip = request.env['REMOTE_ADDR'].to_i
    result = Geocoder.search(ip)
    puts result.first.country.to_s
    country = result.first.country.to_s
    city = result.first.city.to_s
    location = result.first.address || 'JO'

    client_browser = user_agent.browser

    header
    save([country, city, client_browser])

    status, headers, response = @app.call(env)
    [status, headers, response]
  end

  def header
    CSV.open('Client_Information.csv', 'wb') do |csv|
      csv << ['Country', 'City', 'Browser']
    end
  end

  def save(object)
    CSV.open('Client_Information.csv', 'ab') do |csv|
        csv << object
    end
  end

end

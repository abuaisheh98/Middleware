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
    location = result.first.address || 'JO'

    client_browser = user_agent.browser

    header
    save([location, client_browser])

    status, headers, response = @app.call(env)
    [status, headers, response]
  end

  def header
    CSV.open('Client_Information.csv', 'wb') do |csv|
      csv << ['Location', 'Browser']
    end
  end

  def save(object)
    CSV.open('Client_Information.csv', 'ab') do |csv|
        csv << object
    end
  end

end

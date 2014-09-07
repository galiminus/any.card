class Rack::Attack
  throttle('req/ip', :limit => 300, :period => 5.minutes) do |request|
    request.ip
  end
  throttle("ideas/ip", :limit => 10, :period => 10.minutes) do |request|
    if request.path == '/ideas' && request.post?
      request.ip
    end
  end
end

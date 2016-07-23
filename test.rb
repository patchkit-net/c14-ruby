require_relative 'src/api'

platform = OnlineNet::API::Platform.list()[0]
safe = OnlineNet::API::Safe.list()[0]

puts "Using platform: #{platform}"
puts "Using safe: #{safe}"

p OnlineNet::API::Archive.create(safe, "API Test", "API Test", ["ssh"], ["General"], [platform])
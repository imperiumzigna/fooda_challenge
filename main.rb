require 'file'
require 'json'

file = File.read('./data/example.json')

json_payload = JSON.parse(file)

puts json_payload

require 'file'
require 'json'
require_relative './services/event_parser'

file = File.read('./data/example.json')

json_payload = JSON.parse(file)

parser = EventParser.new(json)

parser.run

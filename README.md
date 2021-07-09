### Fooda Challenge

### Commands

### Install Dependencies

'''
bundle install
'''

### Run parser

'''
bundle exec ruby main.rb
'''

### Run RSpec

'''
bundle exec rspec
'''

### Create Code Quality Report

'''
bundle exec rubycritic -p docs/report-rubycritic.html
'''

- If running with docker run:

'''
bundle exec rubycritic -p docs/report-rubycritic.html --no-browser
'''

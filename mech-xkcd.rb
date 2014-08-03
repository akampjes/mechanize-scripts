require 'mechanize'

# Initialize Mechanize Agent
agent = Mechanize.new
agent.get 'http://xkcd.com/'

# Seperate agent for grabbing image so that we don't lose our place
img_agent = Mechanize.new


# This is why you should use UUID instead of int-id
1.upto(1397) do |i|
  # agent remembers the scheme + host, so no need to supply it when navigating somewhere else
  agent.get "/#{i}/"

  # Grab the 3rd image from XKCD page
  img = agent.page.images[2]
  p img.src
  img_agent.get(img.src).save
  p 'saved'
end

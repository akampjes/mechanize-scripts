require 'mechanize'

# Initialize Mechanize Agent
agent = Mechanize.new
agent.get 'http://localhost:3000/'

# Manually setting a cookie, only need to set this once since mechanize will remember and update it
cookie = Mechanize::Cookie.new('_payroll-buddy_session', 'BAh7CEkiD3Nlc3Npb25faWQGOgZFVEkiJTc4ODAwZDU2MGE0YjMxNDllYTUwOThiM2RlZGRjYmM4BjsAVEkiEF9jc3JmX3Rva2VuBjsARkkiMVpKZnEvSWNadFkxMEpPVHM5ckRyU3ZlSW9ZeTJpaCtJWlFyb0pQZ2JlRE09BjsARkkiGXdhcmRlbi51c2VyLnVzZXIua2V5BjsAVFsHWwZpApgFSSIiJDJhJDEwJHpDajRwczU2NlA5WUNQQ3BCSHA5VS4GOwBU--c5c7a56ee4a2730e437de6375d6734ac681c5667').tap do |c|
  c.domain = 'localhost:3000'
  c.path   = '/'
end
agent.cookie_jar.add(agent.history.last.uri, cookie)

# This is why you should use UUID instead of int-id
1.upto(60) do |i|
  # agent remembers the scheme + host
  agent.get '/users/edit'


  agent.page.forms.first.tap do |f|
    f['user[email]']                     = 'mum@gmail.com'
    f['user[name]']                     = 'mum'
    f['user[current_password]']                  = 'aaaaaaaa'
    f['user[organisation_id]'] = "#{i}"
    f.submit
  end

  # Get the root org pages so that we can check change over here 
  agent.get '/'

  # Search for elements on the page
  p i.to_s
  # Searching for Clark Kent on the page
  if agent.page.body.inspect.include? 'Clark Kent'
    puts agent.page.body.inspect
    p "ORG #{i}"
    break
  end
end


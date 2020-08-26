# README

อ่านก่อน
ผลงานตัวอย่างการใช้ ActionCable ของ Ruby on Rails หรือที่เรียกว่า WebSockets
1. ลง Redis gem 'redis'
2. ตั้งค่า ActionCable ใน config/cable.yml
development:
  adapter: redis
  url: <%= ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" } %>
  channel_prefix: rails-chat-tutorial_development
3. ใน config/initializers/warden_hooks.rb สามารถปรับจาก session เป็น cookie ตามด้านล่าง
Warden::Manager.after_set_user do |user,auth,opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
end

Warden::Manager.before_logout do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = nil
end

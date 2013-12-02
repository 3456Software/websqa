desc 'Creates an administrative user'
task :create_admin do
  create_admin
  puts 'Created administrator.'
  puts "email:    'admin@websqa.com'"
  puts "password: 'websqa_admin'"
end

def create_admin
  User.create!(name: 'WebSQA Administrator',
               email: 'admin@websqa.com',
               password: 'websqa_admin',
               password_confirmation: 'websqa_admin',
               admin: true)
end

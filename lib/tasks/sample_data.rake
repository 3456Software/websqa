namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    make_users
    make_projects
    add_requirements
    add_users_to_projects
  end
end

def make_users
  User.create!(name: 'Example Admin',
               email: 'example@railstutorial.org',
               password: 'password',
               password_confirmation: 'password',
               admin: true)

  39.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = 'password'
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_projects
  16.times do |n|
    title = "Example Project #{n+1}"
    desc = "A short description of project #{n+1} goes here."
    Project.create!(title: title, desc: desc)
  end
end

def add_requirements
  projects = Project.all(limit: 6)
  6.times do |n|
    name = "Example requirement #{n+1}"
    projects.each { |project| project.requirements.create(name: name) }
  end
end

def add_users_to_projects
  4.times do |n|
    project = Project.all[n]
    users = User.all[(3 * n + 1)..(3 * n + 3)]
    users.each { |user| project.add_member!(user) }
  end
end

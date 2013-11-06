namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    User.create!(name: 'Rails Tutorial',
                 email: 'example@railstutorial.org',
                 password: 'foobar',
                 password_confirmation: 'foobar',
                 admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    30.times do |n|
      title = "Example Project #{n+1}"
      desc = "A short description of project #{n+1}. Lorem ipsum."
      Project.create!(title: title, desc: desc)
    end

    projects = Project.all(limit: 6)
    8.times do |n|
      name = "Example requirement #{n+1}"
      projects.each { |project| project.requirements.create(name: name) }
    end
  end
end

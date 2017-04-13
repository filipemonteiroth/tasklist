# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Task.create(title: "Start rails project", description: "Start a new rails project to do new things")
Task.create(title: "Create new user", description: "Create new user to rails project")
Task.create(title: "Setup rspec", description: "Setup rspec on project for tests")
Task.create(title: "Setup devise", description: "Setup devise for sample user control")
Task.create(title: "Create tasks model", description: "Create all tasks model for managing tasks")
Task.create(title: "Create tasks controllers", description: "Create tasks controllers for sending data")
Task.create(title: "Create model tests", description: "Create model tests")
Task.create(title: "Create model controllers", description: "Create model tests")

User.create(email: "john@mail.com", password: "12345678")
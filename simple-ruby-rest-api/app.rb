require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'json'

# Set up the database connection using Sequel
DB = Sequel.connect('sqlite://api.db')

# Create a table called `tasks` with this schema
DB.create_table? :tasks do
  primary_key :id
  String :title
  String :description
  Boolean :completed, default: false
end

# Create a Task model to interact with the database
class Task < Sequel::Model
  plugin :json_serializer
end

# Index of all tasks (GET)
get '/tasks' do
  tasks = Task.all
  json tasks
end

# Create a new task (POST)
post '/tasks' do
  data = JSON.parse(request.body.read)
  task = Task.create(title: data['title'], description: data['description'])
  json task
end

# Read an existing task (GET)
get '/tasks/:id' do |id|
  task = Task[id]
  json task
end

# Update an existing task (PUT)
put '/tasks/:id' do |id|
  data = JSON.parse(request.body.read)
  task = Task[id]
  # only update if exists
  if task
    # keep values of un-updated attributes
    task.update(
      title: data['title'] || task.title,
      description: data['description'] || task.description,
      completed: data['completed'] || task.completed
    )
  end
  json task
end

# Delete a task (DELETE)
delete '/tasks/:id' do |id|
  task = Task[id]
  # only delete if exists
  if task
    task.delete
  end
  json task
end

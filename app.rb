require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/division')
require('./lib/employee')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

get('/') do
  @employees = Employee.all()
  # @employees_not_done = @employees.not_done()
  @divisions = Division.all()
  erb(:index)
end

get('/employees/:id/edit') do
  @employee = Employee.find(params.fetch("id").to_i())
  @divisions = Division.all()
  erb(:employee)
end

patch("/employees/:id") do
  name = params.fetch("name")
  division_id = params.fetch("division_id")
  @employee = Employee.find(params.fetch("id").to_i())
  if name != ""
    @employee.update({:name => name})
  end
  if division_id != "nil"
    division_id = params.fetch("division_id").to_i()
      @employee.update({:division_id => division_id})
  end

  @employees = Employee.all()
  @divisions = Division.all()
  erb(:index)
end

post("/employees") do
  name = params.fetch("name")
  division_id = params.fetch("division_id").to_i()
  @division = Division.find(division_id)
  @employee = Employee.new({:name => name, :division_id => division_id})
  @employee.save()
  erb(:division)
end

post('/divisions') do
  name = params[:name]
  new_division = Division.create({:name => name})
  @divisions = Division.all()
  @employees = Employee.all()
  erb(:index)
end

get('/divisions/:id') do
  @division = Division.find(params[:id].to_i())
  @employees = Employee.all()
  erb(:division)
end

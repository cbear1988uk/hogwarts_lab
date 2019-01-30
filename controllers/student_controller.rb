require_relative("../models/student")

get '/students' do
  @students = Student.find_all
  erb(:"students/index")
end

get '/students/new' do
  @houses = House.show_houses
  erb (:'students/new')
end

post '/students' do
  @student = Student.new(params)
  @student.save
  erb (:'students/added')
end

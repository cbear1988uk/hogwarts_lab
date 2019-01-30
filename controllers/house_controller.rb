get '/houses' do
  @all_houses = House.show_houses()
  erb (:'houses/index')
end

get '/houses/:id' do
  @house = House.find_by_id(params[:id].to_i())
  erb (:'houses/show')
end

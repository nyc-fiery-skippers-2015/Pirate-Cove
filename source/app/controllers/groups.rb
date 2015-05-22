get '/groups' do
  all_groups = Group.all
  erb :'/groups/index', locals: {groups: all_groups}
end

get '/groups/new' do
  erb :'groups/new'
end

post '/groups/new' do
  cur_group = Group.new(params[:group])
  return [500, "Invalid Group"] unless cur_group.save
  redirect "/groups/#{cur_group.id}"
end

get '/groups/:id' do
  cur_group = Group.find_by(id: params[:id])
  erb :'groups/show', locals: {group: cur_group}
end

get '/groups/:id/edit' do
  cur_group = Group.find_by(id: params[:id])
  erb :'groups/edit', locals: {group: cur_group}
end

put '/groups/:id/edit' do
  user_input = params[:group]
  cur_group = Group.find_by(id: cur_group.id)
  cur_group.name = user_input[:name]
  redirect "/groups/#{cur_group.id}"
end

delete '/groups/:id/edit' do
  cur_group = Group.find_by(id: params[:id])
  cur_group.destroy
  redirect '/groups'
end

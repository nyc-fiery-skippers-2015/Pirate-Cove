get '/groups' do
  require_logged_in
  all_groups = Group.all
  erb :'/groups/index', locals: {groups: all_groups}
end

get '/groups/new' do
  require_logged_in
  erb :'groups/new'
end

get '/groups/:id' do
  require_logged_in
  cur_group = Group.find_by(id: params[:id])
  member_of?(cur_group)
  erb :'groups/show', locals: {group: cur_group}
end

get '/groups/:id/edit' do
  require_logged_in
  cur_group = Group.find_by(id: params[:id])
  member_of?(cur_group)
  erb :'groups/edit', locals: {group: cur_group}
end

get '/groups/:id/join' do
  require_logged_in
  cur_group = Group.find_by(id: params[:id])
  erb :'groups/join', locals: {group: cur_group}
end

post '/groups/new' do
  require_logged_in
  user_input = params[:group]
  new_group = Group.new(name: user_input[:name], owner: current_user)
  new_group.users << current_user
  return [500, "Invalid Group"] unless new_group.save
  redirect "/groups/#{new_group.id}"
end

post '/groups/:id/join' do
  require_logged_in
  cur_group = Group.find_by(id: params[:id])
  cur_group.users << current_user
  redirect "/groups/#{cur_group.id}"
end

put '/groups/:id/edit' do
  user_input = params[:group]
  cur_group = Group.find_by(id: params[:id])
  cur_group.name = user_input[:name]
  redirect "/groups/#{cur_group.id}"
end

delete '/groups/:id/edit' do
  cur_group = Group.find_by(id: params[:id])
  cur_group.destroy
  redirect '/groups'
end

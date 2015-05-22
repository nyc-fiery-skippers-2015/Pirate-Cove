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
end

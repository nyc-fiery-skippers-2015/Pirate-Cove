get '/groups/:id/posts' do
  cur_group = Group.find_by(id: params[:id])
  member_of?(cur_group)
  erb :'/posts/index', locals:{group: cur_group}
end

get '/groups/:id/posts/new' do
  require_logged_in
  cur_group = Group.find_by(id: params[:id])
  member_of?(cur_group)
  erb :'/posts/new', locals:{group: cur_group}
end

get '/posts/:id' do
  require_logged_in
  cur_post = Post.find_by(id: params[:id])
  cur_group = Group.find_by(id: cur_post.group_id)
  member_of?(cur_group)
  return [500, "Post does not exist"] unless cur_post
  erb :'/posts/show', locals:{post: cur_post}
end

get '/posts/:id/edit' do
  cur_post = Post.find_by(id: params[:id])
  cur_group = Group.find_by(id: cur_post.group_id)
  member_of?(cur_group)
  if session[:user_id] == cur_post.author_id
    return [500, "Post does not exist"] unless cur_post
    erb :'/posts/edit', locals:{post: cur_post}
  else
    redirect '/groups'
  end
end

post '/posts/new' do
  user_input = params[:post]
  new_post = Post.new(title: user_input[:title], body: user_input[:body], author: current_user, group_id: user_input[:group])
  tags = user_input[:tags].split(",").map{|tag|Tag.find_or_create_by(name:tag.strip)}
  tags.each{|tag|new_post.tags << tag}
  return [500, "Invalid Post"] unless new_post.save
  redirect "/posts/#{new_post.id}"
end

put '/posts/:id/edit' do
  cur_post = Post.find_by(id: params[:id])
  cur_post.update(params[:post])
  return [500, "Invalid Post"] unless cur_post.save
  redirect "/posts/#{cur_post.id}"
end

delete '/posts/:id/edit' do
  group_id = params[:post][:group_id]
  cur_post = Post.find_by(id: params[:id])
  return [500, "No Post Found"] unless cur_post
  cur_post.destroy
  redirect "/groups/#{group_id}/posts"
end

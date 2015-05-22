get '/groups/:id/posts' do
  group = Group.find_by(id: params[:id])
  erb :'/posts/index', locals:{group: group}
end

get '/groups/:id/posts/new' do
  require_logged_in
  cur_group = Group.find_by(id: params[:id])
  erb :'/posts/new', locals:{group: cur_group}
end

get '/posts/:id' do
  cur_post = Post.find_by(id: params[:id])
  return [500, "Post does not exist"] unless cur_post
  erb :'/posts/show', locals:{post: cur_post}
end

get '/posts/:id/edit' do
  cur_post = Post.find_by(id: params[:id])
  if session[:user_id] == cur_post.author_id
    return [500, "Post does not exist"] unless cur_post
    erb :'/posts/edit', locals:{post: cur_post}
  else
    redirect '/posts'
  end
end

post '/posts/new' do
  user_input = params[:post]
  new_post = Post.new({title: user_input[:title], body: user_input[:body], group_id: user_input[:group]})
  new_post.author = session[:user_id]
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
  cur_post = Post.find_by(id: params[:id])
  return [500, "No Post Found"] unless cur_post
  cur_post.destroy
  redirect "/posts"
end
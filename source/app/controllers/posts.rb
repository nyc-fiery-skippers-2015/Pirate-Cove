get '/posts' do
  all_posts = Post.all
  erb :'/posts/index', locals:{posts: all_posts}
end

get '/posts/new' do
  require_logged_in
  erb :'/posts/new'
end

get '/posts/:id' do
  cur_post = Post.find_by(id: params[:id])
  author = User.find_by(id: cur_post.author_id)
  return [500, "Post does not exist"] unless cur_post
  erb :'/posts/show', locals:{post: cur_post, author: author}
end

get '/posts/:id/edit' do
  if session[:user_id] == Post.find_by(id: params[:id]).author_id
    cur_post = Post.find_by(id: params[:id])
    return [500, "Post does not exist"] unless cur_post
    erb :'/posts/edit', locals:{post: cur_post}
  else
    redirect '/posts'
  end
end

post '/posts/new' do
  user_input = params[:post]
  new_post = Post.new({title: user_input[:title], body: user_input[:body], author_id: session[:user_id, group_id:})
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
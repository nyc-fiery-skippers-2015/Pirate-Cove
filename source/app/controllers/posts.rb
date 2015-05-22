get '/posts' do
  all_posts = Post.all
  erb :'/posts/index', locals:{posts: all_posts}
end

get '/posts/new' do
  erb :'/posts/new'
end

get '/posts/:id' do

  erb :'/posts/show'
end

post '/posts/new' do
  user_input = params[:post]
  author_id = User.find_by(id: session[:user_id])
  new_post = Post.new({title: user_input[:title], body: user_input[:body], author_id: author_id, group_id:})
  redirect "/posts/:id"
end

put '/posts/:id/edit' do
  cur_post = Post.find_by(id: params[:id])
  return [500, "No Post Found"] unless cur_post
  cur_post.update(params[:post])
  redirect "/posts/:id"
end

delete '/posts/:id/edit' do
  cur_post = Post.find_by(id: params[:id])
  return [500, "No Post Found"] unless cur_post
  cur_post.destroy
  redirect "/posts"
end
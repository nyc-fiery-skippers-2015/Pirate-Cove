get '/posts' do
  all_posts = Post.all
  erb :'/posts/index', locals:{posts: all_posts}
end

get '/posts/new' do
  erb :'/posts/new'
end

post '/posts/new' do
  user_input = params[:post]
  # author_id = User.find_by(id: session[:user_id])
  new_post = Post.new({title: user_input[:title], body: user_input[:body], author_id: author_id, group_id:})
end
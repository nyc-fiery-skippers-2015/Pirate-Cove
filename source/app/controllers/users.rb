get '/users' do
  require_logged_in
  users = User.all
  erb :'users/index' , locals:{users: users}
end

get '/users/signup' do
  erb :'users/signup'
end

get '/users/login' do
  erb :'users/signin'
end

get '/users/:id/edit' do
  require_logged_in
  cur_user = User.find_by(id: params[:id])
  return [500, "No User Found"] unless cur_user
  erb :'users/edit', locals:{user: cur_user}
end


get '/users/:id' do
    require_logged_in
   current_user = User.find_by(id: params[:id])
   return [500, "User not found"] unless current_user
   erb :'users/show' , locals: {user: current_user}
end

post '/users/signup' do
  new_user = User.new(params[:user])
  return [500, "Invalid Credentials"] unless new_user.save
  session[:user_id] = new_user.id
  redirect "/users/#{new_user.id}"
end

post '/users/login' do
  current_user = User.find_by(email: params[:user][:email])
  return [500, "No Email Found"] unless current_user
  if current_user.authenticate(params[:user][:password])
      session[:user_id] = current_user.id
      redirect "/users/#{current_user.id}"
  else
      redirect "/users/login?error=Invalid Login"
  end
end

post '/users/logout' do
  session[:user_id] = nil
  redirect '/'
end

put '/users/:id/edit' do
  cur_user = User.find_by(id: params[:id])
  cur_user.update(params[:user])
  return [500, "Invalid User"] unless cur_user.save
  redirect "/users/#{cur_user.id}"
end

delete '/users/:id/edit' do
  cur_user = User.find_by(id: params[:id])
  cur_user.destroy
  redirect '/'
end



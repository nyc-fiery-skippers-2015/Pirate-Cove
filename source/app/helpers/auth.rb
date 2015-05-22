
def require_logged_in
  redirect('/users/login') unless is_authenticated?
end

def is_authenticated?
  return !!session[:user_id]
end

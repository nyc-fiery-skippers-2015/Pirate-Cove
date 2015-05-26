
def require_logged_in
  redirect('/users/login') unless is_authenticated?
end

def is_authenticated?
  return !!session[:user_id]
end

def current_user
  User.find_by(id: session[:user_id])
end

#This should probably be on group 
def member_of?(cur_group)
  redirect '/groups' unless cur_group.users.include?(current_user)
end

#:thumbsup:
def set_date(timestamp)
  timestamp.strftime("%d %B %Y")
end

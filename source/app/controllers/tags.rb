get '/tags/:name' do
  require_logged_in
  tag = Tag.find_by(name: params[:name])
  return [500, 'Tag Does Not Exist'] unless tag
  erb :'tags/show', locals: {tag:tag}
end

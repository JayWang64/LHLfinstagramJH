helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
      "#{time_ago_in_minutes / 60} hours ago"
    else
      "#{time_ago_in_minutes} minutes ago"
    end
  end
  
  def getLikeOrLikes(count)
    return "likes" if count > 1 or count == 0
    return "like" if count == 1
  end
  
  def getCommentOrComments(count)
    return "comments" if count > 1 or count == 0
    return "comment" if count == 1
  end

end

get '/' do
  @posts = Post.order(created_at: :desc)
  #@current_user = User.find_by(id: session[:user_id])
  erb :index
end

get '/signup' do #if a user navigates to the path /signup
  @user = User.new
  erb :signup
end

post '/signup' do
  email      = params[:emailX]
  avatar_url = params[:avatar_urlX]
  username   = params[:usernameX]
  password   = params[:passwordX]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    redirect(to('/login'))
  else
    erb(:signup)
  end
end

get '/login' do   #when a get request comes into LOGIN
  erb(:login)     #render login.erb
end

post '/login' do
  #params.to_s
  
  user = User.find_by(username: params[:username])
  
  if user && user.password == params[:password]
    session[:user_id] = user.id
    #"Success! User with id #{session[:user_id]} is logged in!"
    
    redirect(to('/'))
    
  else
    @error_message = "Login Failed."
    erb(:login)
    
  end
  
end

get '/logout' do
  session[:user_id] = nil
  redirect(to('/'))
end

get '/posts/new' do
  @post = Post.new
  erb(:"posts/new")
end

post '/posts' do
  #params.to_s
  photo_url = params[:photo_url]
  
  #instantiate a new post
  @post = Post.new({ photo_url: photo_url, user_id: current_user.id})
  
  #if posts is valid, save it
  if @post.save
    redirect(to('/'))
  else
    #if it doesn't validate, post the error msgs
    erb(:"posts/new")
  end
  
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb(:"posts/show")
end


post '/comments' do
  # point values from params to variables
  text = params[:text]
  post_id = params[:post_id]

  # instantiate a comment with those values & assign the comment to the `current_user`
  comment = Comment.new({ text: text, post_id: post_id, user_id: current_user.id })

  # save the comment
  comment.save

  # `redirect` back to wherever we came from
  redirect(back)
end

post '/likes' do
  post_id = params[:post_id]
  
  like = Like.new({ post_id: post_id, user_id: current_user.id})
  like.save
  
  redirect(back)

end

delete '/likes/:id' do
  like = Like.find(params[:id])
  like.destroy
  redirect(back)
end

###
### testing
post '/signupOK' do
  
  email      = params[:emailX]
  avatar_url = params[:avatar_urlX]
  username   = params[:usernameX]
  password   = params[:passwordX]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    "User #{username} saved!"
  else
    erb(:signup)
  end
end
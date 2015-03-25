get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/sign_in' do
  erb :sign_in
end

post '/sign_in' do #
  erb :sign_in
  byebug
  @user_login = User.authenticate(params[:email], params[:password])
  byebug
  if @user_login
    session[:user_id] = @user_login.id
    redirect to '/url_list'
  else
    session[:error] = "Invalid username or password."
    redirect to '/'
  end
end

get '/create_account' do
  erb :create_account
end

post '/sign_up' do
  @account = User.create(params[:user])
  # @account = User.create(full_name: params[:full_name], email: params[:email], password: params[:password])
  erb :index
end

# e.g., /q6bda
get '/url_list' do #
  erb :url_list
end

post '/url_list' do #
  @url = Url.create(params[:url])

  if @url.valid?
  #adds latest long & short url entry into Url table
  redirect to("/url_list")
  else
  erb :index
  end
end

get '/shorten_url' do
   erb :shorten_url
end

get '/sign_out' do
  erb :sign_out
end


=begin
The core flow of the URL shortener should remain the same, however a person might choose to log in or create an account. In the event that they're logged in when they shorten a URL, this Url should now be associated with their user account. In other words, a Url belongs to a User and a User has many Urls.

People should be able to create short URLs regardless of whether they're logged in or not. That is, the user_id field on the urls table could possible be NULL.

However, if a user is logged in, when we create a URL it should set the user_id to whatever the user_id of the currently logged-in user is. This information should not be a part of the form that a user submits ‰ÛÓ it would be trivial for someone to change the content of the form and submit as any user.

Instead, create a users helper at app/helpers/user.rb. It should contain a method that works like this:
=end


# get '/' do
#   # Look in app/views/index.erb
#   erb :index
# end

# post '/urls' do
#   # obtain new Url from index.erb
#   # params[:url][:short_url] = [*0..9, *'A'..'Z'].sample(7).join
#   # appends [:url] to long url and short url
#   @url = Url.create(params[:url])

#   if @url.valid?
#   #adds latest long & short url entry into Url table
#   redirect to("/url_list")
# else
#   erb :index
# end
# end

# get '/url_list' do
#   @urls = Url.all
#   erb :url_list
# end

# # e.g., /q6bda
# get '/:short_url' do
#   # redirect to appropriate "long" URL
#   #call the value of short url --> long url
#   @url = Url.find_by_short_url(params[:short_url])
#   if @url.nil?
#     redirect to '/'
#   end
#   @url.click_count += 1
#   @url.save

#   redirect to @url.long_url
#   # Url.find(params[:url][:short_url])
#   # params[:url][:short_url] += 1
# end
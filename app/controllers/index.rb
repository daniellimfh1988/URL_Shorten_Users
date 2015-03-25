get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/urls' do
  # obtain new Url from index.erb
  # params[:url][:short_url] = [*0..9, *'A'..'Z'].sample(7).join
  # appends [:url] to long url and short url
  @url = Url.create(params[:url])

  if @url.valid?
  #adds latest long & short url entry into Url table
  redirect to("/url_list")
else
  erb :index
end
end

get '/url_list' do
  @urls = Url.all
  erb :url_list
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  #call the value of short url --> long url
  @url = Url.find_by_short_url(params[:short_url])
  if @url.nil?
    redirect to '/'
  end
  @url.click_count += 1
  @url.save

  redirect to @url.long_url
  # Url.find(params[:url][:short_url])
  # params[:url][:short_url] += 1
end
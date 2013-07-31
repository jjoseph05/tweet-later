get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token
  user = User.create(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  session[:id] = user.id

  redirect to '/'
  
end

get '/status/:job_id' do
  # return the status of a job to an AJAX call
end


#<OAuth::AccessToken:0x007f831a97fac8 @token="1078234284-8CPxAjNy6LMOlwCPUZQ61f1xzcPJBOrERpD8yKl", @secret="d7i2NXCRHD2dmKnL4QhUkofHxoW1gFH96zsBI5Sdqs", @consumer=#<OAuth::Consumer:0x007f831a417068 @key="yumRi3hs4L61gQSEF03jGQ", @secret="yJ5QC1sZA7yGJhDni0uYWpVqvIDjiN9CBtThWRvpuI", @options={:signature_method=>"HMAC-SHA1", :request_token_path=>"/oauth/request_token", :authorize_path=>"/oauth/authorize", :access_token_path=>"/oauth/access_token", :proxy=>nil, :scheme=>:header, :http_method=>:post, :oauth_version=>"1.0", :site=>"https://api.twitter.com"}, @http_method=:post, @http=#<Net::HTTP api.twitter.com:443 open=false>>, @params={:oauth_token=>"1078234284-8CPxAjNy6LMOlwCPUZQ61f1xzcPJBOrERpD8yKl", "oauth_token"=>"1078234284-8CPxAjNy6LMOlwCPUZQ61f1xzcPJBOrERpD8yKl", :oauth_token_secret=>"d7i2NXCRHD2dmKnL4QhUkofHxoW1gFH96zsBI5Sdqs", "oauth_token_secret"=>"d7i2NXCRHD2dmKnL4QhUkofHxoW1gFH96zsBI5Sdqs", :user_id=>"1078234284", "user_id"=>"1078234284", :screen_name=>"jjoseph05", "screen_name"=>"jjoseph05"}>

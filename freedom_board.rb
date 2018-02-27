require 'sinatra'
require 'yaml/store'

get '/' do
  erb :index
end

post '/' do
  @text = params['text']
  @user = params['user']
  
  Post = Struct.new :user, :text
  post = Post.new(@user, @text)
  store = YAML::Store.new "post.store"
  
  store.transaction do
	store["post"] = post
  end
 
  erb :index 
end

	



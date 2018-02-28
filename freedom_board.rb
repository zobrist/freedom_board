require 'sinatra'
require 'yaml/store'
require 'yaml'
require 'date'

get '/' do
  erb :index
end

post '/' do
  @text = params['text']
  @user = params['user']
  @time = (DateTime.now).strftime "%m/%d/%Y %H:%M:%S"
  
  if @user == '' then @user = 'Anonymous' end
  
  #Post = Struct.new :user, :text, :time
  #post = Post.new(@user, @text, @time)
  @store = YAML::Store.new "posts.yml"
  
  @store.transaction do
	@store[@time] = [@user, @text]
  end
 
  erb :index 
end

	



require 'sinatra'
require 'yaml/store'
require 'yaml'
require 'date'

def load_file
  if File.exist?("posts.yml")
    @posts = YAML.load(File.read("posts.yml"))
  end
end

get '/' do 
  load_file
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
  
  load_file
  erb :index 
end

post '/search' do
  load_file
  @keyword = params['search']
  @posts = @posts.select{|time, value| value[1] =~ Regexp.new(@keyword)}
  erb :index
end 

	



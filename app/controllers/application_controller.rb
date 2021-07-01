
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all

    erb :index
  end

  get '/articles/new' do
    @id = Article.last.id + 1
    erb :new
  end

  get '/articles/:id' do
    @id = params[:id]
    @article = Article.find(@id)

    erb :show
  end

  post '/articles' do
    @article = Article.create(:title => params[:title], :content => params[:content])
    redirect to "/articles/#{@article.id}"
    erb :show
  end

  get '/articles/:id/edit' do
    @id = params[:id]
    @article = Article.find(@id)

    erb :edit
  end

  patch '/articles/:id' do
    @title = params[:title]
    @content = params[:content]
    @article = Article.find(params[:id])
    @article = Article.update(title: @title, content: @content)
    
    erb :show
  end

  delete '/articles/:id' do
    @id = params[:id]
    Article.destroy(@id)
    @articles = Article.all

    erb :index
  end
end

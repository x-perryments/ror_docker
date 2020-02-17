class HomeController < ApplicationController
  def index
    @message = "static page"

    @posts = Post.all
  end
end

class PublicController < ApplicationController
  def index
    session[:test] = 'hello'
  end
end

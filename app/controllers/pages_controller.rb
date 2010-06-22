class PagesController < ApplicationController
  def home
    @mixes = Mix.all(:order => 'CREATED_AT DESC', :limit => 10)
    @feeds = Feed.all(:order => 'CREATED_AT DESC', :limit => 10)
  end
end

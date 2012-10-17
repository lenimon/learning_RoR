class PagesController < ApplicationController
  def home
    @title="dynamic home variable"
  end

  def contact
    @title="dynamic contact variable"
  end

  def about
    @title="dynamic about variable"
  end
end

class StaticController < ApplicationController
  def index
    render :article
  end

  def about
    render :about, layout: false
  end

  def contact
    render :contact, layout: false
  end
end
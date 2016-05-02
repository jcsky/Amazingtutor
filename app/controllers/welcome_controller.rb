class WelcomeController < ApplicationController
  def index
    @teacher =Teacher.all
  end
end

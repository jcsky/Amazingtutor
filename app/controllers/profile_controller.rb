class ProfileController < ApplicationController
  def profile
    @order = Order.new
  end
end

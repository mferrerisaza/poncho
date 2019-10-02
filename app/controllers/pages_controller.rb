class PagesController < ApplicationController
  def home
    @is_full_path = false
  end

  def plans
    @is_full_path = true
  end
end

class PagesController < ApplicationController

  def about
    # 實體變數
    @numbers = (1..42).to_a.sample(5)
  end

end

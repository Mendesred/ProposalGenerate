class HomeController < ApplicationMainController
  def index
  	@select_all_calculation = Calculation.first
  	@proposal = Proposal.first
  end
end

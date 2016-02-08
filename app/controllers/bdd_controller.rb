class BddController < ApplicationController
  def index
    @customers = Customer.order(:last_name, :first_name).page params[:page]
  end

  def show
    @customer = Customer.find_by_id(params[:id])
  end

  def edit

  end

  def destroy
    @customer = Customer.find_by_id(params[:id])
    @customer.destroy
    flash[:notice] = "Successfully deleted customer: #{@customer.email}!"
    redirect_to action: "index"
  end
end

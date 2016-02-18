class CustomerController < ApplicationController
  def index
    @customers = Customer.order(:last_name, :first_name).page params[:page]
  end

  def show
    @customer = Customer.find_by_id(params[:id])
  end

  def edit
    @customer = Customer.find_by_id(params[:id])
  end

  def update
    @customer = Customer.find_by_id(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "Successfully updated customer: #{@customer.email}"
      redirect_to @customer
    else
      flash[:alert] = "Cannot update customer #{@customer.email}"
      render action: "edit"
    end
  end

  def destroy
    @customer = Customer.find_by_id(params[:id])
    if @customer.destroy
      flash[:notice] = "Successfully deleted customer: #{@customer.email}"
    else
      flash[:alert] = "Cannot delete customer #{@customer.email}"
    end
    redirect_to action: "index"
  end

  private

  def customer_params
    params.require(:customer)
        .permit(
            :first_name,
            :last_name,
            :email,
            :country,
            :city,
            :postal_code,
            :region,
            :address_code,
            :organisation_name,
            :phone_number
        )
  end
end
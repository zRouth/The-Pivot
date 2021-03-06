class BusinessesController < ApplicationController
  before_action :current_business, only: [:show, :admin, :update, :admin]
  before_action :require_business_admin, only: [:admin]

  def index
    @business = Business.where :active => true
  end

  def show
    if current_business
      @listings = Listing.order(title: :asc).select { |listing| listing.business_id == current_business.id && current_business.active?}
    end
  end

  def admin
    authorize! :admin, current_business, :alert => "You are Not Authorized to access that page"
    @listings = Listing.all.select { |listing| listing.business_id == current_business.id}
  end

  def new
    @business ||= Business.new
  end

  def create
    @business = Business.new(business_params)
    @current_business = @business
    if @business.save
      BusinessesMailer.created_email(@business).deliver
      current_user.update_attribute(:business_id, @business.id)
      flash[:notice] = "Business created"
      redirect_to root_url subdomain: @business.slug
    else
      flash[:error] = "Business could not be created"
      @errors = @user.errors.map do |attribute, msg|
        "#{attribute.to_s.gsub("_", " ").capitalize}: #{msg.downcase}"
      end.uniq
      render :new
    end
  end

  def update
    authorize! :update, current_business
    current_business.update(business_params)
    redirect_to business_path(current_business)
  end


private

  def business_params
    params.require(:business).permit(:name, :address, :state, :phone, :email, :slug, :url, :description, :active)
  end
end

class ReviewsController < ApplicationController

  before_action :ensure_logged_in, :only => [:create, :destroy, :edit, :update]
  before_action :load_product


  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = @product.reviews.build(review_params) # @product comes from the load_product
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to product_path(@product.id), :notice => "Review created successfully" }
        format.js {} #looks for reviews/create.js.erb
        format.json { render json: @review, include: :user } # render json for that object # you can do :user because a review belongs to a user
      else
        format.html { render 'products/show', :alert => "Oops! Something went wrong!"  }
        format.js {}
        format.json { render json: @review } # render json for that object
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

private
  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end

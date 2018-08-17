class ReviewsController < ApplicationController
  def create
    product = Product.find params[:product_id]
    current_user = User.find(session[:user_id]) if session[:user_id]
    @review = Review.new(review_params)

    @review.product_id = product.id
    @review.user_id = current_user.id
    if @review.valid?
      @review.save!
    end
    redirect_to product
  end

  private

  def review_params
    params[:product].require(:reviews).permit(
      :description,
      :rating,
      :product_id,
      :user_id
    )
  end
end

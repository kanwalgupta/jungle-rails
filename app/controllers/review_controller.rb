class ReviewController < ApplicationController
    before_filter :deny_access, :unless => :current_user?
    def create
      @review = Review.new(review_params)
      @review.user_id = current_user.id
      @review.product_id = params[:product_id]
       if @review.save
        redirect_to Product.find params[:product_id]
      else
        redirect_to Product.find params[:product_id]
      end
    end
     def destroy
      @review = Review.find params[:id]
      @product_id = @review.product_id
      @review.destroy
      redirect_to Product.find @product_id
    end
     def current_user?
      current_user
    end
     private
     def review_params
      params.require(:review).permit(
        :description,
        :rating
      )
    end
end

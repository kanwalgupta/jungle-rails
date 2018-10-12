class UserMailer < ApplicationMailer
    default from: 'no-reply@jungle.com '
    def order_placed_email(user,order, line_items)
        
        @user = user
        @order = order
        @line_items = line_items
        @url  = 'http://localhost:3000'
        mail(to: @user.email, subject: "Order Placed for order id #{order.id}")
      end
      def get_product_info product_id
        Product.find_by(id: product_id)
      end
      helper_method :get_product_info
end

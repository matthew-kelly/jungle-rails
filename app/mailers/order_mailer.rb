class OrderMailer < ApplicationMailer
  default from: "no-reply@jungle.com"
  # layout 'order_summary_email'

  def order_summary_email(order)
    @order = order
    @user = order.email
    
    puts mail(to: @user, subject: 'Your Order Summary | Jungle')
  end
end

class OrderMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_summary_email(order)
    @order = order
    @user = order.email
    
    puts mail(to: @user, subject: @order.id)
  end
end

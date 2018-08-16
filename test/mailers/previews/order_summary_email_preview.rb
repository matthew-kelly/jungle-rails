class OrderMailerPreview < ActionMailer::Preview
# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
  def order_summary_email_preview
    OrderMailer.order_summary_email(Order.first)
  end
end
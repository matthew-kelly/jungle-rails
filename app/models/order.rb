class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true


  def send_order_summary_email
    OrderMailer.order_summary_email(self).deliver_now
    # OrderMailerPreview.order_summary_email_preview(self).deliver_now
  end
end

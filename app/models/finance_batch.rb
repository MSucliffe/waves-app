class FinanceBatch < ApplicationRecord
  belongs_to :processed_by, class_name: "User"
  has_many :finance_payments, foreign_key: :batch_id,
                              class_name: "Payment::FinancePayment"

  protokoll :batch_no, pattern: "1#####"

  def total_amount
    finance_payments.sum(&:payment_amount)
  end

  def toggle_state!
    closed? ? reopen_batch! : close_batch!
  end

  def closed?
    closed_at.present? && !locked?
  end

  def open?
    closed_at.blank? && !locked?
  end

  def close_batch!
    update_attributes(closed_at: Time.now)
  end

  def reopen_batch!
    update_attributes(closed_at: nil)
  end

  def lock!
    finance_payments.map(&:lock!)
    update_attributes(locked_at: Time.now)
  end

  def locked?
    locked_at.present?
  end
end

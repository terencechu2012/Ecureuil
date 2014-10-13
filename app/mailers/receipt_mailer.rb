class ReceiptMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def send_email(ereceipt)
    @ereceipt = ereceipt
    mail(to: @ereceipt.payeemail, subject: 'Your e-receipt')
  end
end

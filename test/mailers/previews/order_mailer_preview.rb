# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
    def send_order_email 
        #test email preview
        order = Order.find(5)
        customer = User.find(2)
        OrderMailer.with(order: order, customer: customer).send_order_email
    end
end

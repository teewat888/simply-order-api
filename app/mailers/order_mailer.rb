class OrderMailer < ApplicationMailer
    def send_order_email
        #get info from order controller
        @order = params[:order]
        @customer = params[:customer]
        @greeting = "Hi,"
        @intro_message = "Please see the below order details from "
        @end_message = "Kind Regards,"
        @powered_by = "Powered by: Simply Order App, Simplified your order process, https://iwebpro.com.au/simplyorder"

        @to_email = "teewat@yahoo.com";
        @subject = "test from rails"
       
        mail( to: @to_email, subject: @subject)
    end
end

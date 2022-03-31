class ResetPasswordMailer < ApplicationMailer
    def send_reset_email
        @token = params[:token]
        @user = params[:user]
        @to_email = "#{@user.email},teewat@yahoo.com";
        @subject = "Password reset instruction from Simply-order"
       
        mail( to: @to_email, subject: @subject)
    end
end

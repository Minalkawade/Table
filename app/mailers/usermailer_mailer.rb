class UsermailerMailer < ApplicationMailer
default from: 'minal.k@infiny.in'
   
   def welcome_email(user)
      @user = user
      # @url  = 'http://www.gmail.com'
      mail(to: @user.email, subject: 'Welcome to My Alpha Blog')
   end
   
end


class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
       @url  = "http://timecast.heroku.com/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @url  = "http://timecast.heroku.com/"
  end
  
  protected

  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "timecast@taryneast.org"
    @subject     = "[TimeCast] "
    @sent_on     = Time.now
    @user = user
  end

end

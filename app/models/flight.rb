class Flight < ActiveRecord::Base

  belongs_to :airline

  def status
    return "LANDED" if estimated_at < DateTime.now
    return "DELAYED" if estimated_at > scheduled_at
    return "ON TIME"
  end

  def share
    require 'twilio-ruby'

    # put your own credentials here
    account_sid = ENV['TWILIO_CLASS_DEMO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_CLASS_DEMO_AUTH_TOKEN']

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    obj = @client.account.messages.create({
    	:from => '+12242063763',
      :to => '+18472194848',
      :body => "#{self.airline.name} ##{self.number} will arrive at #{self.estimated_at.strftime("%B %d, %Y  %l:%M %P")}"
    })

    # Rails.logger.info obj.inspect
  end
end

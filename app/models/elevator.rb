class Elevator < ApplicationRecord
    belongs_to :column
    # belongs_to :column, through: => :batteries
    # rescue_from StandardError do |exception|
    after_save :send_change_to_slack, if: proc { saved_change_to_status? } 
    after_save :trigger_sms_alerts, if: proc { saved_change_to_status?(to: 'Intervention') }
    


def send_change_to_slack
  notifier = Slack::Notifier.new ENV['SLACK_BOT_URL']
  message = "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{self.status_before_last_save} to #{self.status}."
  notifier.ping(message)
end

def trigger_sms_alerts
    alert_message = "#{self.column.battery.building.name_technical_building}
    the elevator located at #{self.column.battery.building.address.number_and_street} serial number:#{self.serial_number} need your intervention  "
    admins = YAML.load_file('config/administrators.yml')
    # admins = YAML.load_file('config/database.yml')

    admins.each do |admin|
      begin
        phone_number = admin['phone_number']
        send_message(phone_number, alert_message)

      end
    end
  end

  def index
  end

  def server_error
    raise 'A test exception'
  end

  private

  def send_message(phone_number, alert_message)
    twilio_number = ENV['TWILIO_NUMBER']
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    client.messages.create(
      from: twilio_number,
      to:   phone_number,
      body: alert_message,
      # US phone numbers can make use of an image as well
      # media_url: image_url
    )
  end

    def status_enum
        ['Offline', 'Online', 'Intervention']
    end 

end


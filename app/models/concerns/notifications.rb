module Notifications
  module InstanceMethods
    def send_push(msg)
      users = receivers.device_ids_not_null
      ios_users = users.push_eligible_user('ios')
      android_users = users.push_eligible_user('android')
      begin
        if ios_users.present?
          APNS.send_notification(ios_users, alert: msg, sound: 'default')
          puts '====MESSAGE SENT===='
        end
        if android_users.present?
          GCM.send_notification(android_users, :alert => msg, :badge => 1, :sound => 'default')
        end
      rescue Exception => e
        puts "-----#{e.message}----"
      end
      end
    end
  end

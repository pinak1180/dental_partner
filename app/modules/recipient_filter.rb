module RecipientFilter
  def self.included(base)
    base.send(:extend, ClassMethods)
    base.send(:include, InstanceMethods)
  end
  module ClassMethods
    def valid_feeds(user_id)
      joins(:recipient).where("'#{user_id}' = ANY (recipients.recipient_ids)")
    end
  end
  module InstanceMethods
    def create_recipient_filter
      user_arel = User.arel_table
      user_ids = User.where(user_arel[:direct_report_ids].contains(direct_report_ids).or(user_arel[:department_ids].contains(department_ids))
       .or(user_arel[:practise_code_ids].contains(practise_code_ids))
       .or(user_arel[:department_ids].contains(department_ids))
       .or(user_arel[:access_level_ids].contains(access_level_ids))
       .or(user_arel[:position_ids].contains(position_ids))).ids
      create_recipient(recipient_ids: user_ids)
    end
   end
end

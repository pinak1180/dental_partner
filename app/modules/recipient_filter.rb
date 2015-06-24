module RecipientFilter
  def self.included(base)
    base.send(:extend, ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      scope :latest,-> { order('created_at DESC') }
    end
  end
  module ClassMethods
    def valid_feeds(user)
      arel = self.arel_table
      where(arel[:direct_report_ids].overlap(user.direct_report_ids)
        .or(arel[:department_ids].overlap(user.department_ids))
        .or(arel[:practise_code_ids].overlap(user.practise_code_ids))
        .or(arel[:access_level_ids].overlap(user.access_level_ids))
        .or(arel[:position_ids].overlap(user.position_ids)))
    end
  end
  module InstanceMethods
    def receivers
      arel = User.arel_table
      User.where(arel[:direct_report_ids].overlap(direct_report_ids)
        .or(arel[:department_ids].overlap(department_ids))
        .or(arel[:practise_code_ids].overlap(practise_code_ids))
        .or(arel[:access_level_ids].overlap(access_level_ids))
        .or(arel[:position_ids].overlap(position_ids)))
    end

    def print_release_date
      release_date.strftime("%d-%m-%Y")
    end

    def print_expiry_date
      expiry_date.present? ? expiry_date.strftime("%d-%m-%Y") : 'N/A'
    end

    def departments
      Department.where(id: department_ids).uniq.pluck(:name).join(', ')
    end

    def access_levels
      AccessLevel.where(id: access_level_ids).uniq.pluck(:level).join(', ')
    end

    def positions
      Position.where(id: position_ids).uniq.pluck(:name).join(', ')
    end

    def practise_codes
      PractiseCode.where(id: practise_code_ids).uniq.pluck(:code).join(', ')
    end

    def direct_report_users
      User.where(id: direct_report_ids).uniq.pluck(:email).join(',')
    end

    private
    def atleast_single_reciptient
      errors.add(:position_ids, "atleast single criteria must be selected") unless (position_ids || department_ids || practise_code_ids || direct_report_ids).present?
    end

    def correct_expiry_date
      if expiry_date.present?
        errors.add(:expiry_date, "must be greater than Release Date") unless release_date.present? && release_date <= expiry_date
      end
    end
  end
end

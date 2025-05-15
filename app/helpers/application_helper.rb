# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_alert_class(flash_type)
    case flash_type.to_sym
    when :success then "success"
    when :error, :alert then "danger"
    when :notice then "info"
    else "primary"
    end
  end

  def human_state_name(state)
    t("bulletin.state_names.#{state}")
  end

  def human_date(from_time)
    distance_of_time_in_words(from_time, Time.zone.now)
  end

  def user_present?
    controller.current_user.present?
  end

  def user_admin?
    controller.current_user.present? && controller.current_user.admin
  end
end

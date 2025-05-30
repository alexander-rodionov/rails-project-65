# frozen_string_literal: true

module Admin
  module ApplicationControllerHelper
    def for_moderation?
      page_signature == 'bulletins#index#under_moderation'
    end

    def page_signature
      "#{controller_name}##{action_name}##{params&.[](:q)&.[](:state_eq)}"
    end

    def page_selector_css(page_selector, css_class)
      css_class if page_selector == page_signature
    end

    def controller_selector_css(controller_selector, css_class)
      css_class if controller_selector == controller_name
    end
  end
end

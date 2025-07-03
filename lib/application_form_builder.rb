class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field email_field password_field number_field].each do |method_name|
    define_method(method_name) do |method, options = {}|
      has_error = object.present? && object.respond_to?(:errors) && object.errors[method].present?
      css_classes = [options[:class], ('is-invalid' if has_error)].compact.join(' ')
      options[:class] = css_classes

      field_html = super(method, options)
      error_html = if has_error
        @template.content_tag(:div, object.errors[method].first, class: 'invalid-feedback')
      else
        ''.html_safe
      end

      field_html + error_html
    end
  end
end

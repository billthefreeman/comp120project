def error_span(attribute)
    @template.content_tag :span, errors_for(attribute), class: 'help-inline'
  end
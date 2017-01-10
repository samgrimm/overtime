module PostsHelper
  def status_label status
    status_span_generator status
  end

  private

  def status_span_generator status
    case status
    when 'submitted'
      content_tag(:td, status.titleize, class: 'table-info')
    when 'approved'
      content_tag(:td, status.titleize, class: 'table-success')
    when 'rejectec'
      content_tag(:td, status.titleize, class: 'table-danger')
    end
  end
end

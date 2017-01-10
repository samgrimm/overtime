module ApplicationHelper

  def active?(path)
    "active" if current_page?(path)
  end

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
      when 'rejected'
        content_tag(:td, status.titleize, class: 'table-danger')
      when 'pending'
        content_tag(:td, status.titleize, class: 'table-danger')
      when 'confirmed'
        content_tag(:td, status.titleize, class: 'table-success')
    end
  end
  
end

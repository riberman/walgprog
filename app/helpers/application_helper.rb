module ApplicationHelper
  def full_title(page_title = '', base_title = 'WalgProg')
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning',
      notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
    end
    def logo_color
      e = Event.order(end_date: :desc).first
      return e.color if e

      '#000'
    end
  end

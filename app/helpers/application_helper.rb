module ApplicationHelper
  def full_title(page_title = '', base_title = 'WAlgProg')
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
    date = DateTime.now.utc
    e = Event.where(['beginning_date >= :beginning_year and end_date <= :end_year',
                     { beginning_year: date.beginning_of_year, end_year: date.end_of_year }]).first
    return e.color if e

    '#000'
  end
end

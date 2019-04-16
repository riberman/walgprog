module BreadcrumbHelper
  def ensure_navigation
    @navigation ||= [ { :title => t('helpers.home'), :url => '/' } ]
  end

  def navigation_add(title, url)
    ensure_navigation << { :title => title, :url => url }
  end

  def render_navigation
    render :partial => 'shared/breadcrumb', :locals => {:nav => ensure_navigation }
  end
end
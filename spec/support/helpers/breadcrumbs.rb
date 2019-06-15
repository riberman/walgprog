module Helpers
  module Breadcrumbs
    def text_for_home
      I18n.t('breadcrumbs.homepage')
    end

    def text_for_index
      I18n.t('breadcrumbs.action.index', resource_name: resource_name_plural)
    end

    def text_for_parent
      I18n.t('breadcrumbs.action.index', resource_name: parent_name)
    end

    def text_for_new_m
      I18n.t('breadcrumbs.action.new.m', resource_name: resource_name)
    end

    def text_for_new_f
      I18n.t('breadcrumbs.action.new.f', resource_name: resource_name)
    end

    def text_for_edit
      I18n.t('breadcrumbs.action.edit', resource_name: resource_name)
    end
  end
end

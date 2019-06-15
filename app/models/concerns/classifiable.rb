require 'active_support/concern'

module Classifiable
  extend ActiveSupport::Concern

  included do
    enum user_type: { administrator: 'A', collaborator: 'C' }

    def self.human_user_types
      hash = {}
      user_types.each_key { |key| hash[I18n.t("enums.user_types.#{key}")] = key }
      hash
    end
  end
end

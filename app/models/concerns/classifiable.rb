require 'active_support/concern'

module Classifiable
  extend ActiveSupport::Concern

  included do
    enum user_type: { administrator: 'A', collaborator: 'C' }, _prefix: :user_type

    def self.human_user_types
      hash = {}
      user_types.each { |key, value| hash[I18n.t("enums.user_types.#{key}")] = value }
      hash
    end
  end
end

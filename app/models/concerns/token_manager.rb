require 'active_support/concern'

module TokenManager
  extend ActiveSupport::Concern

  included do
    EXPIRATION_TOKEN_TIME = 2.hours
  end

  module ClassMethods
    attr_reader :token_fields

    private

    def register_tokens(*token_fields)
      @token_fields = token_fields
      define_token_methods
    end

    def define_token_methods
      @token_fields.each do |token|
        define_method_generate_token(token)
        define_method_valid_token(token)
        define_method_invalidate_token(token)
        define_method_update_with_token(token)
      end
    end

    def define_method_generate_token(token)
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def generate_#{token}_token
          word = "\#{email}-\#{Time.zone.now.to_f}"
          token = Digest::SHA1.hexdigest(word)

          update(#{token}_token: token, #{token}_send_at: Time.zone.now)
          token
        end
      RUBY
    end

    def define_method_valid_token(token)
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def valid_#{token}_token?(token)
          return false unless token.eql?(#{token}_token)

          expiration_time = #{token}_send_at + EXPIRATION_TOKEN_TIME
          return false if Time.zone.now > expiration_time

          true
        end
      RUBY
    end

    def define_method_invalidate_token(token)
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def invalidate_#{token}_token
          update(#{token}_send_at: #{token}_send_at - EXPIRATION_TOKEN_TIME)
        end
      RUBY
    end

    def define_method_update_with_token(token)
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def update_with_#{token}_token(token, data)
          unless valid_#{token}_token?(token)
            errors.add(:token, "Token #{I18n.t('errors.messages.invalid')}")
            return false
          end

          return false unless update(data)

          invalidate_#{token}_token
        end
      RUBY
    end
  end
end

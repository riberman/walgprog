module DateFormatter
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def beginning_date
      bd = super
      bd.class_eval do
        def formatted
          self ? I18n.l(self, format: :short) : nil
        end
      end
      bd
    end

    def end_date
      ed = super
      ed.class_eval do
        def formatted
          self ? I18n.l(self, format: :short) : nil
        end
      end
      ed
    end
  end
end

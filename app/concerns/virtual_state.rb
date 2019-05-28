module VirtualState

  module Model
    extend ActiveSupport::Concern

    included do
      attr_writer :state_id
    end

    def state
      return city.state if city

      State.find_by(id: state_id) if state_id
    end

    def state_id
      return city.state.try(:id) if city

      @state_id
    end
  end

  module Controller
    extend ActiveSupport::Concern

    included do
      before_action :load_states, only: [:new, :create, :edit, :update]
    end

    def load_states
      @states = State.order(:name)
      @cities = []
    end

    def load_cities
      variable = "@#{controller_name.singularize}"
      model = instance_variable_get(variable)

      state = model.state
      @cities = state.cities if state
    end
  end
end

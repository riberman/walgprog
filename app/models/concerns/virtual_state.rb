module VirtualState
  extend ActiveSupport::Concern

  def state
    return city.state if city

    State.find_by(id: state_id) if state_id
  end

  def state_id
    return city.state.try(:id) if city

    @state_id
  end

  def load_states
    @states = State.order(:name)
    @cities = []
  end

  def load_cities(model)
    state = model.state
    @cities = state.cities if state
  end
end

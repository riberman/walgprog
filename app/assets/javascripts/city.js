$(document).on('turbolinks:load', () => {
  WAlgProg.classes.StateAndCities.init('#institution_state_id', '#institution_city_id');
  WAlgProg.classes.StateAndCities.init('#event_state_id', '#event_city_id');
});

WAlgProg.classes.StateAndCities = class {
  constructor(state, city) {
    this.state = state;
    this.city = city;
  }

  selectizeElements() {
    $(this.state).selectize();

    this.citySelectize = $(this.city).selectize({
      valueField: 'id',
      labelField: 'name',
      searchField: ['name'],
      create: false,
    })[0].selectize;

    $('.selectize-input input[placeholder]').attr('style', 'width: 100%;');
  }

  disableCityWhenHasNoElements() {
    const els = this.citySelectize.options;

    if (Object.keys(els).length <= 0) this.citySelectize.disable();
  }

  applyChangeEventOnState() {
    $(this.state).on('change', () => {
      const stateId = this.getSelectedState();
      if (stateId === '') {
        this.clearCity();
        return;
      }

      $.ajax({
        method: 'GET',
        url: `/states/${stateId}/cities`,
        error: () => {
          this.citySelectize.disable();
          this.clearCity();
        },
        success: (response) => {
          this.clearCity();
          this.citySelectize.enable();
          this.citySelectize.load((callback) => {
            callback(response.cities);
          });
        },
      });
    });
  }

  clearCity() {
    this.citySelectize.clear();
    this.citySelectize.clearOptions();
  }

  getSelectedState() {
    return $(this.state).val();
  }

  isOnPage() {
    return ($(this.city).length > 0
      && $(this.state).length > 0);
  }

  static init(stateSelector, citySelector) {
    const sc = new WAlgProg.classes.StateAndCities(stateSelector, citySelector);
    if (!sc.isOnPage()) return;

    sc.selectizeElements();
    sc.disableCityWhenHasNoElements();
    sc.applyChangeEventOnState();
  }
};

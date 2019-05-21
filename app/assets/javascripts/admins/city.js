$(document).on('turbolinks:load', () => {
  WAlgProg.classes.StateAndCities.init();
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

  disbleCityWhenHasNoElements() {
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
        url: `/admins/states/${stateId}/cities`,
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

  static init() {
    const sc = new WAlgProg.classes.StateAndCities('#institution_state_id', '#institution_city_id');
    if (!sc.isOnPage()) return;

    sc.selectizeElements();
    sc.disbleCityWhenHasNoElements();
    sc.applyChangeEventOnState();
  }
};

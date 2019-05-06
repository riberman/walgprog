$(document).on('turbolinks:load', () => {
    WalgProg.classes.StateAndCities.init();
});

WalgProg.classes.StateAndCities = class {

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
    }

    disbleCityWhenHasNoElements() {
        let els = this.citySelectize.options;

        if (Object.keys(els).length <= 0)
            this.citySelectize.disable();
    }

    applyChangeEventOnState() {
        $(this.state).on('change', () => {
            let state_id = this.getSelectedState();
            if (state_id == '') {
                this.clearCity();
                return;
            }

            $.ajax({
                method: 'GET',
                url: '/admins/states/' + state_id + '/cities',
                error: (response) => {
                    this.citySelectize.disable();
                    this.clearCity();
                },
                success: (response) => {
                    this.clearCity();
                    this.citySelectize.enable();
                    this.citySelectize.load(function(callback) {
                        callback(response['cities']);
                    });
                }
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
        return ($(this.city).length > 0 &&
            $(this.state).length > 0);
    }

    static init() {
        let sc = new WalgProg.classes.StateAndCities('#institution_state_id', '#institution_city_id');
        if (!sc.isOnPage()) return;

        sc.selectizeElements();
        sc.disbleCityWhenHasNoElements();
        sc.applyChangeEventOnState();
    }
}

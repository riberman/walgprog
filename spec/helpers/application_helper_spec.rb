require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full title' do
    it 'defaulf' do
      expect(helper.full_title).to eql('WAlgProg')
    end

    it 'title' do
      expect(helper.full_title('Home')).to eql('Home | WAlgProg')
    end
  end

  describe 'flash' do
    it 'success to bootstrap class alert' do
      expect(helper.bootstrap_class_for('success')).to eql('alert-success')
    end
    it 'error to bootstrap class alert' do
      expect(helper.bootstrap_class_for('error')).to eql('alert-danger')
    end
    it 'alert to bootstrap class alert' do
      expect(helper.bootstrap_class_for('alert')).to eql('alert-warning')
    end
    it 'notice to bootstrap class alert' do
      expect(helper.bootstrap_class_for('notice')).to eql('alert-info')
    end
    it 'any other to same bootstrap class alert' do
      expect(helper.bootstrap_class_for('danger')).to eql('danger')
    end
  end

  describe '#sidebar' do
    context 'with defaulf sidebar in' do
      before(:each) do
        assign(:event, Event.new)
        allow(helper).to receive(:controller_name).and_return('events')
      end

      it 'action new' do
        allow(helper).to receive(:action_name).and_return('new')
        expect(helper.sidebar).to eql('layouts/admins/sidebar')
      end

      it 'action create' do
        allow(helper).to receive(:action_name).and_return('create')
        expect(helper.sidebar).to eql('layouts/admins/sidebar')
      end

      it 'action edit' do
        allow(helper).to receive(:action_name).and_return('edit')
        expect(helper.sidebar).to eql('layouts/admins/sidebar')
      end

      it 'action update' do
        allow(helper).to receive(:action_name).and_return('update')
        expect(helper.sidebar).to eql('layouts/admins/sidebar')
      end
    end
  end

  context 'with @event nil' do
    it 'sidebar' do
      allow(helper).to receive(:controller_name).and_return('')
      expect(helper.sidebar).to eql('layouts/admins/sidebar')
    end
  end

  context 'with event sidebar' do
    it 'events controller action show' do
      allow(helper).to receive(:controller_name).and_return('events')
      allow(helper).to receive(:action_name).and_return('show')
      assign(:event, Event.new)

      expect(helper.sidebar).to eql('layouts/admins/event_sidebar')
    end

    it '@event any controller and action' do
      allow(helper).to receive(:controller_name).and_return('sections')
      allow(helper).to receive(:action_name).and_return('new')
      assign(:event, Event.new)

      expect(helper.sidebar).to eql('layouts/admins/event_sidebar')
    end
  end
end

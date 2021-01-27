require 'rails_helper'

RSpec.describe AreasController, :type => :controller do
  let(:user) { create(:user) }

  before { @request.session['user_id'] = user.id }

  describe 'GET #index' do
    let(:get_index) { get :index }

    it { expect(get: '/areas').to route_to(controller: 'areas', action: 'index') }

    it 'returns 200' do
      get_index
      expect(response.status).to eq(200)
    end

    context 'when there are many areas' do
      let(:areas_attrs_with_progress) do
        user.areas.map { |area| area.attributes_with_progress }
      end

      it 'returns a json of all existing user areas' do
        create_list(:area, 3, user: user)
        get_index
        expect(response.body).to eq(areas_attrs_with_progress.to_json)
      end
    end

    context 'when there isnt any areas' do
      it 'returns an empty json array' do
        get_index
        expect(response.body).to eq([].to_json)
      end
    end
  end

  describe 'POST #create' do
    let(:attributes) { attributes_for(:area).merge(user_id: user.id) }
    let(:created_area) { user.areas.last }
    let(:post_create) { post :create, params: {area: attributes} }

    it { expect(post: '/areas').to route_to(controller: 'areas', action: 'create') }

    it 'creates an area with the given attributes' do
      post_create
      expect(created_area).to have_attributes(attributes)
    end

    it 'returns 200' do
      post_create
      expect(response.status).to eq(200)
    end

    it 'returns the created area json' do
      post_create
      expect(response.body).to eq(created_area.attributes_with_progress.to_json)
    end
  end

  describe 'GET #show' do
    def get_show_with(id)
      get :show, params: {id: id}
    end

    it { expect(get: '/areas/123').to route_to(controller: 'areas', action: 'show', 'id': '123') }

    context 'when area exists' do
      let(:area) { create(:area, user: user) }

      it 'returns 200' do
        get_show_with(area.id)
        expect(response.status).to eq(200)
      end

      it 'returns the area json' do
        get_show_with(area.id)
        expect(response.body).to eq(area.attributes_with_progress.to_json)
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Area couldnt be found' }

      it 'returns 404' do
        get_show_with(12)
        expect(response.status).to eq(404)
      end

      it 'returns an error message json' do
        get_show_with(12)
        expect(response.body).to eq({error: {message: not_found_message}}.to_json)
      end
    end
  end

  describe 'PUT #update' do
    def put_update_with(id, attrs)
      put :update, params: {id: id, area: attrs}
    end

    let(:attributes) { attributes_for(:area) }

    it { expect(put: '/areas/123').to route_to(controller: 'areas', action: 'update', 'id': '123') }

    context 'when area exists' do
      let(:area) { create(:area, user: user) }

      it 'returns 200' do
        put_update_with(area.id, attributes)
        expect(response.status).to eq(200)
      end

      it 'creates a area with the given attributes' do
        put_update_with(area.id, attributes)
        expect(area.reload).to have_attributes(attributes)
      end

      it 'returns the created area json' do
        put_update_with(area.id, attributes)
        expect(response.parsed_body.except('created_at', 'updated_at', 'progress')).to(
          eq(area.reload.attributes_with_progress.except('created_at', 'updated_at', 'progress'))
        )
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Area couldnt be found' }

      it 'returns 404' do
        put_update_with(123, attributes)
        expect(response.status).to eq(404)
      end

      it 'returns an error message json' do
        put_update_with(123, attributes)
        expect(response.body).to eq({error: {message: not_found_message}}.to_json)
      end
    end
  end

  describe 'DELETE #destroy' do
    def delete_with(id)
      delete :destroy, params: {id: id}
    end

    it { expect(delete: '/areas/123').to route_to(controller: 'areas', action: 'destroy', 'id': '123') }

    context 'when area exists' do
      let(:area) { create(:area, user: user) }

      it 'returns 200' do
        delete_with(area.id)
        expect(response.status).to eq(200)
      end

      it 'creates a task with the given attributes' do
        delete_with(area.id)
        expect{ area.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'returns the created area json' do
        delete_with(area.id)
        expect(response.body).to eq(area.attributes_with_progress.to_json)
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Area couldnt be found' }

      it 'returns 404' do
        delete_with(123)
        expect(response.status).to eq(404)
      end

      it 'returns an error message json' do
        delete_with(123)
        expect(response.body).to eq({error: {message: not_found_message}}.to_json)
      end
    end
  end
end

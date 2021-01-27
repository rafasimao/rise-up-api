require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  let(:user) { create(:user) }

  before { @request.session['user_id'] = user.id }

  describe 'GET #index' do
    let(:get_index) { get :index }

    it { expect(get: '/tasks').to route_to(controller: 'tasks', action: 'index') }

    it 'returns 200' do
      get_index
      expect(response.status).to eq(200)
    end

    context 'when there are many tasks' do
      it 'returns a json of all existing user tasks' do
        create_list(:task, 3, user: user)
        get_index
        expect(response.body).to eq(user.tasks.to_json)
      end
    end

    context 'when there isnt any tasks' do
      it 'returns an empty json array' do
        get_index
        expect(response.body).to eq([].to_json)
      end
    end
  end

  describe 'POST #create' do
    let(:attributes) { attributes_for(:task).merge(user_id: user.id) }
    let(:created_task) { user.tasks.last }
    let(:post_create) { post :create, params: {task: attributes} }

    it { expect(post: '/tasks').to route_to(controller: 'tasks', action: 'create') }

    it 'creates a task with the given attributes' do
      post_create
      expect(created_task).to have_attributes(attributes)
    end

    it 'returns 200' do
      post_create
      expect(response.status).to eq(200)
    end

    it 'returns the created task json' do
      post_create
      expect(response.body).to eq(created_task.to_json)
    end
  end

  describe 'GET #show' do
    def get_show_with(id)
      get :show, params: {id: id}
    end

    it { expect(get: '/tasks/123').to route_to(controller: 'tasks', action: 'show', 'id': '123') }

    context 'when task exists' do
      let(:task) { create(:task, user: user) }

      it 'returns 200' do
        get_show_with(task.id)
        expect(response.status).to eq(200)
      end

      it 'returns the task json' do
        get_show_with(task.id)
        expect(response.body).to eq(task.to_json)
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Task couldnt be found' }

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
      put :update, params: {id: id, task: attrs}
    end

    let(:attributes) { attributes_for(:task) }

    it { expect(put: '/tasks/123').to route_to(controller: 'tasks', action: 'update', 'id': '123') }

    context 'when task exists' do
      let(:task) { create(:task, user: user) }

      it 'returns 200' do
        put_update_with(task.id, attributes)
        expect(response.status).to eq(200)
      end

      it 'creates a task with the given attributes' do
        put_update_with(task.id, attributes)
        expect(task.reload).to have_attributes(attributes)
      end

      it 'returns the created task json' do
        put_update_with(task.id, attributes)
        expect(response.parsed_body.except('created_at', 'updated_at')).to(
          eq(task.reload.attributes.except('created_at', 'updated_at'))
        )
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Task couldnt be found' }

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

    it { expect(delete: '/tasks/123').to route_to(controller: 'tasks', action: 'destroy', 'id': '123') }

    context 'when task exists' do
      let(:task) { create(:task, user: user) }

      it 'returns 200' do
        delete_with(task.id)
        expect(response.status).to eq(200)
      end

      it 'creates a task with the given attributes' do
        delete_with(task.id)
        expect{ task.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'returns the created task json' do
        delete_with(task.id)
        expect(response.body).to eq(task.to_json)
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Task couldnt be found' }

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

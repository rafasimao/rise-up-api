require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user) { create(:user) }

  before { @request.session['user_id'] = user.id }

  describe 'GET #index' do
    let(:get_index) { get :index }

    it { expect(get: '/projects').to route_to(controller: 'projects', action: 'index') }

    it 'returns 200' do
      get_index
      expect(response.status).to eq(200)
    end

    context 'when there are many projects' do
      let(:projects_attrs_with_progress) do
        user.projects.map { |project| project.attributes_with_progress }
      end

      it 'returns a json of all existing user projects' do
        create_list(:project, 3, user: user)
        get_index
        expect(response.body).to eq(projects_attrs_with_progress.to_json)
      end
    end

    context 'when there isnt any projects' do
      it 'returns an empty json array' do
        get_index
        expect(response.body).to eq([].to_json)
      end
    end
  end

  describe 'POST #create' do
    let(:attributes) { attributes_for(:project).merge(user_id: user.id) }
    let(:created_project) { user.projects.last }
    let(:post_create) { post :create, params: {project: attributes} }

    it { expect(post: '/projects').to route_to(controller: 'projects', action: 'create') }

    it 'creates an project with the given attributes' do
      post_create
      expect(created_project).to have_attributes(attributes)
    end

    it 'returns 200' do
      post_create
      expect(response.status).to eq(200)
    end

    it 'returns the created project json' do
      post_create
      expect(response.body).to eq(created_project.attributes_with_progress.to_json)
    end
  end

  describe 'GET #show' do
    def get_show_with(id)
      get :show, params: {id: id}
    end

    it { expect(get: '/projects/123').to route_to(controller: 'projects', action: 'show', 'id': '123') }

    context 'when project exists' do
      let(:project) { create(:project, user: user) }

      it 'returns 200' do
        get_show_with(project.id)
        expect(response.status).to eq(200)
      end

      it 'returns the project json' do
        get_show_with(project.id)
        expect(response.body).to eq(project.attributes_with_progress.to_json)
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Project couldnt be found' }

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
      put :update, params: {id: id, project: attrs}
    end

    let(:attributes) { attributes_for(:project) }

    it { expect(put: '/projects/123').to route_to(controller: 'projects', action: 'update', 'id': '123') }

    context 'when project exists' do
      let(:project) { create(:project, user: user) }

      it 'returns 200' do
        put_update_with(project.id, attributes)
        expect(response.status).to eq(200)
      end

      it 'creates a project with the given attributes' do
        put_update_with(project.id, attributes)
        expect(project.reload).to have_attributes(attributes)
      end

      it 'returns the created project json' do
        put_update_with(project.id, attributes)
        expect(response.parsed_body.except('created_at', 'updated_at', 'progress')).to(
          eq(project.reload.attributes_with_progress.except('created_at', 'updated_at', 'progress'))
        )
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Project couldnt be found' }

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

    it { expect(delete: '/projects/123').to route_to(controller: 'projects', action: 'destroy', 'id': '123') }

    context 'when project exists' do
      let(:project) { create(:project, user: user) }

      it 'returns 200' do
        delete_with(project.id)
        expect(response.status).to eq(200)
      end

      it 'creates a task with the given attributes' do
        delete_with(project.id)
        expect{ project.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'returns the created project json' do
        delete_with(project.id)
        expect(response.body).to eq(project.attributes_with_progress.to_json)
      end
    end

    context 'when doesnt exist' do
      let(:not_found_message) { 'Project couldnt be found' }

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

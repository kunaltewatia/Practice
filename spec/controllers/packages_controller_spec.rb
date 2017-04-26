require 'rails_helper'

RSpec.describe PackagesController, type: :controller do
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all packages as @packages' do
      package = Package.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:packages)).to eq([package])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested package as @package' do
      package = Package.create! valid_attributes
      get :show, { id: package.to_param }, valid_session
      expect(assigns(:package)).to eq(package)
    end
  end

  describe 'GET #new' do
    it 'assigns a new package as @package' do
      get :new, {}, valid_session
      expect(assigns(:package)).to be_a_new(Package)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested package as @package' do
      package = Package.create! valid_attributes
      get :edit, { id: package.to_param }, valid_session
      expect(assigns(:package)).to eq(package)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Package' do
        expect do
          post :create, { package: valid_attributes }, valid_session
        end.to change(Package, :count).by(1)
      end

      it 'assigns a newly created package as @package' do
        post :create, { package: valid_attributes }, valid_session
        expect(assigns(:package)).to be_a(Package)
        expect(assigns(:package)).to be_persisted
      end

      it 'redirects to the created package' do
        post :create, { package: valid_attributes }, valid_session
        expect(response).to redirect_to(Package.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved package as @package' do
        post :create, { package: invalid_attributes }, valid_session
        expect(assigns(:package)).to be_a_new(Package)
      end

      it "re-renders the 'new' template" do
        post :create, { package: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested package' do
        package = Package.create! valid_attributes
        put :update, { id: package.to_param,  package: new_attributes },
            valid_session
        package.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested package as @package' do
        package = Package.create! valid_attributes
        put :update, { id: package.to_param,  package: valid_attributes },
            valid_session
        expect(assigns(:package)).to eq(package)
      end

      it 'redirects to the package' do
        package = Package.create! valid_attributes
        put :update, { id: package.to_param,  package: valid_attributes },
            valid_session
        expect(response).to redirect_to(package)
      end
    end

    context 'with invalid params' do
      it 'assigns the package as @package' do
        package = Package.create! valid_attributes
        put :update, { id: package.to_param,  package: invalid_attributes },
            valid_session
        expect(assigns(:package)).to eq(package)
      end

      it "re-renders the 'edit' template" do
        package = Package.create! valid_attributes
        put :update, { id: package.to_param,  package: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested package' do
      package = Package.create! valid_attributes
      expect do
        delete :destroy, { id: package.to_param }, valid_session
      end.to change(Package, :count).by(-1)
    end

    it 'redirects to the packages list' do
      package = Package.create! valid_attributes
      delete :destroy, { id: package.to_param }, valid_session
      expect(response).to redirect_to(packages_url)
    end
  end
end

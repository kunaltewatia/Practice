require 'rails_helper'

RSpec.describe PlanProductsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/plan_products').to route_to('plan_products#index')
    end

    it 'routes to #new' do
      expect(get: '/plan_products/new').to route_to('plan_products#new')
    end

    it 'routes to #show' do
      expect(get: '/plan_products/1').to route_to('plan_products#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/plan_products/1/edit')
        .to route_to('plan_products#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/plan_products').to route_to('plan_products#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/plan_products/1')
        .to route_to('plan_products#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/plan_products/1')
        .to route_to('plan_products#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/plan_products/1')
        .to route_to('plan_products#destroy', id: '1')
    end
  end
end

require 'rails_helper'

RSpec.describe 'plan_products/new', type: :view do
  before(:each) do
    assign(:plan_product, PlanProduct.new(product: nil, package: nil,
                                          measurement: nil,
                                          quantity: 1))
  end

  it 'renders new plan_product form' do
    render

    assert_select 'form[action=?][method=?]', plan_products_path, 'post' do
      assert_select 'input#plan_product_product_id[name=?]',
                    'plan_product[product_id]'

      assert_select 'input#plan_product_package_id[name=?]',
                    'plan_product[package_id]'

      assert_select 'input#plan_product_measurement_id[name=?]',
                    'plan_product[measurement_id]'

      assert_select 'input#plan_product_quantity[name=?]',
                    'plan_product[quantity]'
    end
  end
end

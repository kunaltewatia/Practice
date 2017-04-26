require 'rails_helper'

RSpec.describe 'plan_products/edit', type: :view do
  before(:each) do
    @plan_product = assign(:plan_product, PlanProduct.create!(product: nil,
                                                              package: nil,
                                                              measurement: nil,
                                                              quantity: 1))
  end

  it 'renders the edit plan_product form' do
    render

    assert_select 'form[action=?][method=?]',
                  plan_product_path(@plan_product), 'post' do
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

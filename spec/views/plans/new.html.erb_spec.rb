require 'rails_helper'

RSpec.describe 'plans/new', type: :view do
  before(:each) do
    assign(:plan, Plan.new(pack: nil, name: 'MyString', description: 'MyText',
                           old_price: 'MyString', decimal: 'MyString',
                           price: '9.99', days: 1, is_active: false))
  end

  it 'renders new plan form' do
    render

    assert_select 'form[action=?][method=?]', plans_path, 'post' do
      assert_select 'input#plan_pack_id[name=?]', 'plan[pack_id]'

      assert_select 'input#plan_name[name=?]', 'plan[name]'

      assert_select 'textarea#plan_description[name=?]', 'plan[description]'

      assert_select 'input#plan_old_price[name=?]', 'plan[old_price]'

      assert_select 'input#plan_decimal[name=?]', 'plan[decimal]'

      assert_select 'input#plan_price[name=?]', 'plan[price]'

      assert_select 'input#plan_days[name=?]', 'plan[days]'

      assert_select 'input#plan_is_active[name=?]', 'plan[is_active]'
    end
  end
end

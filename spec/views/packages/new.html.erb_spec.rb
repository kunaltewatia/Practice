require 'rails_helper'

RSpec.describe 'packages/new', type: :view do
  before(:each) do
    assign(:package, Package.new(name: 'MyString', plan: nil))
  end

  it 'renders new package form' do
    render

    assert_select 'form[action=?][method=?]', packages_path, 'post' do
      assert_select 'input#package_name[name=?]', 'package[name]'

      assert_select 'input#package_plan_id[name=?]', 'package[plan_id]'
    end
  end
end

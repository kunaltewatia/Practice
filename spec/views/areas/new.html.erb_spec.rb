require 'rails_helper'

RSpec.describe 'areas/new', type: :view do
  before(:each) do
    assign(:area, Area.new(name: 'MyString', city: nil, is_active: false))
  end

  it 'renders new area form' do
    render
    assert_select 'form[action=?][method=?]', areas_path, 'post' do
      assert_select 'input#area_name[name=?]', 'area[name]'

      assert_select 'input#area_city_id[name=?]', 'area[city_id]'

      assert_select 'input#area_is_active[name=?]', 'area[is_active]'
    end
  end
end

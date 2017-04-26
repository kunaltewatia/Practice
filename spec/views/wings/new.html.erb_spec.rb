require 'rails_helper'

RSpec.describe 'wings/new', type: :view do
  before(:each) do
    assign(:wing, Wing.new(name: 'MyString', society: nil, is_active: false))
  end

  it 'renders new wing form' do
    render

    assert_select 'form[action=?][method=?]', wings_path, 'post' do
      assert_select 'input#wing_name[name=?]', 'wing[name]'

      assert_select 'input#wing_society_id[name=?]', 'wing[society_id]'

      assert_select 'input#wing_is_active[name=?]', 'wing[is_active]'
    end
  end
end

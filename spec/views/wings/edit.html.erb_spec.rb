require 'rails_helper'

RSpec.describe 'wings/edit', type: :view do
  before(:each) do
    @wing = assign(:wing, Wing.create!(name: 'MyString',
                                       society: nil,
                                       is_active: false))
  end

  it 'renders the edit wing form' do
    render

    assert_select 'form[action=?][method=?]', wing_path(@wing), 'post' do
      assert_select 'input#wing_name[name=?]', 'wing[name]'

      assert_select 'input#wing_society_id[name=?]', 'wing[society_id]'

      assert_select 'input#wing_is_active[name=?]', 'wing[is_active]'
    end
  end
end

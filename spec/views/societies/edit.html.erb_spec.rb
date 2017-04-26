require 'rails_helper'

RSpec.describe 'societies/edit', type: :view do
  before(:each) do
    @society = assign(:society, Society.create!(name: 'MyString',
                                                locality: nil,
                                                latitude: 'MyString',
                                                longlatitude: 'MyString',
                                                is_active: false))
  end

  it 'renders the edit society form' do
    render

    assert_select 'form[action=?][method=?]', society_path(@society), 'post' do
      assert_select 'input#society_name[name=?]', 'society[name]'

      assert_select 'input#society_locality_id[name=?]', 'society[locality_id]'

      assert_select 'input#society_latitude[name=?]', 'society[latitude]'

      assert_select 'input#society_longlatitude[name=?]',
                    'society[longlatitude]'

      assert_select 'input#society_is_active[name=?]', 'society[is_active]'
    end
  end
end

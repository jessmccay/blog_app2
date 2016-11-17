require 'rails_helper'

RSpec.describe "blogs/edit", type: :view do
  before(:each) do
    @blog = assign(:blog, Blog.create!(
      :title => "MyString",
      :contents => "MyText",
      :user => nil
    ))
  end

  it "renders the edit blog form" do
    render

    assert_select "form[action=?][method=?]", blog_path(@blog), "post" do

      assert_select "input#blog_title[name=?]", "blog[title]"

      assert_select "textarea#blog_contents[name=?]", "blog[contents]"

      assert_select "input#blog_user_id[name=?]", "blog[user_id]"
    end
  end
end

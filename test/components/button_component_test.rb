# frozen_string_literal: true

require "test_helper"

class ButtonComponentTest < ViewComponent::TestCase
  test "renders a button component" do
    render_inline(ButtonComponent.new(text: 'Click me!', url: 'goog.com'))
    assert_selector("a", text: "Click me!")
  end
end

$:.unshift 'test'
require 'test_helper'
require 'bb-ruby'

class BbCodeTest < ActiveSupport::TestCase
  test "test bbcode" do
    html = "[quote=coolguy]You're mom![/quote]
    No, [b]your[/b] mom.".bbcode_to_html

    assert html

    assert html !~ /\[/i
    assert html =~ /<\/(b|strong)>/i
    assert "[quote]" =~ /\[\/?quote/
    assert "[/quote]" =~ /\[\/?quote/
  end
end

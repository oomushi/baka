require 'test_helper'

class BbcodesHelperTest < ActionView::TestCase
  setup do
    @s = "[quote='abc'][:P][quote=\"xyz\"][:B][spoiler][b]gdhsagdjsa[/b][/spoiler][quote=qwerty][/quote][/quote][/quote]"
  end
  test "should parse correct test" do
    ret = bb @s
    assert_equals "<fieldset><legend>abc</legend><blockquote><img src=\"/assets/p.png\"/><fieldset><legend>xyz</legend><blockquote><img src=\"/assets/b.png\"/><span class=\"spoiler\"><strong>gdhsagdjsa</strong></span></blockquote></fieldset></blockquote></fieldset>"
  end
end

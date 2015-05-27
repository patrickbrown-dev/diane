defmodule Diane.UtilTest do
  use ExUnit.Case, async: true
  import Diane.Util

  test "determine_format can recognize ATOM feeds" do
    source = """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
    </feed>
    </xml>
    """
    assert determine_format(source) == {:ok, :atom}
  end

  test "determine_format returns error message on unrecognized formats." do
    source = """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="somethinghasgoneterriblywrong">
    </feed>
    </xml>
    """
    assert determine_format(source) == {:error, "Unrecognized format"}
  end

  test "fails sanely on total garbage input" do
    source = "oasetuhaos´ø´¨åteuhasotnehustoaheusnthostst[95343.c*<($t4]"
    assert determine_format(source) == {:error, "Unrecognized format"}
  end
end

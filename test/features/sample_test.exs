defmodule LordCore.Features.SampleTest do
  use LordCore.ConnCase

  # Import Hound helpers
  use Hound.Helpers

  # Start a Hound session
  hound_session

  test "GET /", meta do
    navigate_to "/"
    assert page_source =~ "Welcome to Phoenix"
  end
end


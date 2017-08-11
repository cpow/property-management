defmodule LordCore.ErrorViewTest do
  use LordCoreWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @tag :no_user
  test "renders 404.html" do
    assert render_to_string(LordCoreWeb.ErrorView, "404.html", []) ==
           "Page not found"
  end

  @tag :no_user
  test "render 500.html" do
    assert render_to_string(LordCoreWeb.ErrorView, "500.html", []) ==
           "Internal server error"
  end

  @tag :no_user
  test "render any other" do
    assert render_to_string(LordCoreWeb.ErrorView, "505.html", []) ==
           "Internal server error"
  end
end

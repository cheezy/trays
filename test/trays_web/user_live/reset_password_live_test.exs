defmodule TraysWeb.UserResetPasswordLiveTest do
  use TraysWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Trays.AccountsFixtures

  alias Trays.Accounts

  setup do
    user = user_fixture()

    token =
      extract_user_token(fn url ->
        Accounts.deliver_user_reset_password_instructions(user, url)
      end)

    %{token: token, user: user}
  end

  describe "Reset password page" do
    test "renders reset password with valid token", %{conn: conn, token: token} do
      {:ok, _lv, html} = live(conn, ~p"/en/users/reset_password/#{token}")

      assert html =~ "Reset Password"
    end

    test "does not render reset password with invalid token", %{conn: conn} do
      {:error, {:redirect, to}} = live(conn, ~p"/en/users/reset_password/invalid")

      assert to == %{
               flash: %{"error" => "Reset password link is invalid or it has expired."},
               to: ~p"/en/"
             }
    end

    test "renders errors for invalid data", %{conn: conn, token: token} do
      {:ok, lv, _html} = live(conn, ~p"/en/users/reset_password/#{token}")

      result =
        lv
        |> element("#reset_password_form")
        |> render_change(
          user: %{"password" => "secret1", "password_confirmation" => "secret123456"}
        )

      assert result =~ "should be at least 8 character"
      assert result =~ "at least one upper case character"
      assert result =~ "does not match password"
    end
  end

  describe "Reset Password" do
    test "resets password once", %{conn: conn, token: token, user: user} do
      {:ok, lv, _html} = live(conn, ~p"/en/users/reset_password/#{token}")

      {:ok, conn} =
        lv
        |> form("#reset_password_form",
          user: %{
            "password" => "new Valid Password !",
            "password_confirmation" => "new Valid Password !"
          }
        )
        |> render_submit()
        |> follow_redirect(conn, ~p"/en/users/log_in")

      refute get_session(conn, :user_token)
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Password reset successfully"
      assert Accounts.get_user_by_email_and_password(user.email, "new Valid Password !")
    end

    test "does not reset password on invalid data", %{conn: conn, token: token} do
      {:ok, lv, _html} = live(conn, ~p"/en/users/reset_password/#{token}")

      result =
        lv
        |> form("#reset_password_form",
          user: %{
            "password" => "short",
            "password_confirmation" => "does not match"
          }
        )
        |> render_submit()

      assert result =~ "Reset Password"
      assert result =~ "should be at least 8 character(s)"
      assert result =~ "at least one digit or punctuation character"
      assert result =~ "at least one upper case character"
      assert result =~ "does not match password"
    end
  end

  describe "Reset password navigation" do
    test "redirects to login page when the Log in button is clicked", %{conn: conn, token: token} do
      {:ok, lv, _html} = live(conn, ~p"/en/users/reset_password/#{token}")

      {:ok, conn} =
        lv
        |> element(~s|main a:fl-contains("Log in")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/en/users/log_in")

      assert conn.resp_body =~ "Log in"
    end

    test "redirects to registration page when the Register button is clicked", %{
      conn: conn,
      token: token
    } do
      {:ok, lv, _html} = live(conn, ~p"/en/users/reset_password/#{token}")

      {:ok, conn} =
        lv
        |> element(~s|main a:fl-contains("Register")|)
        |> render_click()
        |> follow_redirect(conn, ~p"/en/users/register")

      assert conn.resp_body =~ "Register"
    end
  end
end

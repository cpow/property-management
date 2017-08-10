defmodule LordCore.StripeAccountsTest do
  use LordCore.DataCase

  alias LordCore.StripeAccounts

  describe "accounts" do
    alias LordCore.StripeAccounts.Account

    @valid_attrs %{display_name: "some display_name", email: "some email", type: "some type"}
    @update_attrs %{display_name: "some updated display_name", email: "some updated email", type: "some updated type"}
    @invalid_attrs %{display_name: nil, email: nil, type: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StripeAccounts.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert StripeAccounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert StripeAccounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = StripeAccounts.create_account(@valid_attrs)
      assert account.display_name == "some display_name"
      assert account.email == "some email"
      assert account.type == "some type"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, account} = StripeAccounts.update_account(account, @update_attrs)
      assert %Account{} = account
      assert account.display_name == "some updated display_name"
      assert account.email == "some updated email"
      assert account.type == "some updated type"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.update_account(account, @invalid_attrs)
      assert account == StripeAccounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = StripeAccounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> StripeAccounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = StripeAccounts.change_account(account)
    end
  end

  describe "external_accounts" do
    alias LordCore.StripeAccounts.ExternalAccount

    @valid_attrs %{token: "some token"}
    @update_attrs %{token: "some updated token"}
    @invalid_attrs %{token: nil}

    def external_account_fixture(attrs \\ %{}) do
      {:ok, external_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StripeAccounts.create_external_account()

      external_account
    end

    test "list_external_accounts/0 returns all external_accounts" do
      external_account = external_account_fixture()
      assert StripeAccounts.list_external_accounts() == [external_account]
    end

    test "get_external_account!/1 returns the external_account with given id" do
      external_account = external_account_fixture()
      assert StripeAccounts.get_external_account!(external_account.id) == external_account
    end

    test "create_external_account/1 with valid data creates a external_account" do
      assert {:ok, %ExternalAccount{} = external_account} = StripeAccounts.create_external_account(@valid_attrs)
      assert external_account.token == "some token"
    end

    test "create_external_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.create_external_account(@invalid_attrs)
    end

    test "update_external_account/2 with valid data updates the external_account" do
      external_account = external_account_fixture()
      assert {:ok, external_account} = StripeAccounts.update_external_account(external_account, @update_attrs)
      assert %ExternalAccount{} = external_account
      assert external_account.token == "some updated token"
    end

    test "update_external_account/2 with invalid data returns error changeset" do
      external_account = external_account_fixture()
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.update_external_account(external_account, @invalid_attrs)
      assert external_account == StripeAccounts.get_external_account!(external_account.id)
    end

    test "delete_external_account/1 deletes the external_account" do
      external_account = external_account_fixture()
      assert {:ok, %ExternalAccount{}} = StripeAccounts.delete_external_account(external_account)
      assert_raise Ecto.NoResultsError, fn -> StripeAccounts.get_external_account!(external_account.id) end
    end

    test "change_external_account/1 returns a external_account changeset" do
      external_account = external_account_fixture()
      assert %Ecto.Changeset{} = StripeAccounts.change_external_account(external_account)
    end
  end

  describe "legal_entities" do
    alias LordCore.StripeAccounts.LegalEntity

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", type: "some type"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", type: "some updated type"}
    @invalid_attrs %{first_name: nil, last_name: nil, type: nil}

    def legal_entity_fixture(attrs \\ %{}) do
      {:ok, legal_entity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StripeAccounts.create_legal_entity()

      legal_entity
    end

    test "list_legal_entities/0 returns all legal_entities" do
      legal_entity = legal_entity_fixture()
      assert StripeAccounts.list_legal_entities() == [legal_entity]
    end

    test "get_legal_entity!/1 returns the legal_entity with given id" do
      legal_entity = legal_entity_fixture()
      assert StripeAccounts.get_legal_entity!(legal_entity.id) == legal_entity
    end

    test "create_legal_entity/1 with valid data creates a legal_entity" do
      assert {:ok, %LegalEntity{} = legal_entity} = StripeAccounts.create_legal_entity(@valid_attrs)
      assert legal_entity.first_name == "some first_name"
      assert legal_entity.last_name == "some last_name"
      assert legal_entity.type == "some type"
    end

    test "create_legal_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.create_legal_entity(@invalid_attrs)
    end

    test "update_legal_entity/2 with valid data updates the legal_entity" do
      legal_entity = legal_entity_fixture()
      assert {:ok, legal_entity} = StripeAccounts.update_legal_entity(legal_entity, @update_attrs)
      assert %LegalEntity{} = legal_entity
      assert legal_entity.first_name == "some updated first_name"
      assert legal_entity.last_name == "some updated last_name"
      assert legal_entity.type == "some updated type"
    end

    test "update_legal_entity/2 with invalid data returns error changeset" do
      legal_entity = legal_entity_fixture()
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.update_legal_entity(legal_entity, @invalid_attrs)
      assert legal_entity == StripeAccounts.get_legal_entity!(legal_entity.id)
    end

    test "delete_legal_entity/1 deletes the legal_entity" do
      legal_entity = legal_entity_fixture()
      assert {:ok, %LegalEntity{}} = StripeAccounts.delete_legal_entity(legal_entity)
      assert_raise Ecto.NoResultsError, fn -> StripeAccounts.get_legal_entity!(legal_entity.id) end
    end

    test "change_legal_entity/1 returns a legal_entity changeset" do
      legal_entity = legal_entity_fixture()
      assert %Ecto.Changeset{} = StripeAccounts.change_legal_entity(legal_entity)
    end
  end

  describe "tos_acceptances" do
    alias LordCore.StripeAccounts.TosAcceptance

    @valid_attrs %{date: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{date: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{date: nil}

    def tos_acceptance_fixture(attrs \\ %{}) do
      {:ok, tos_acceptance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StripeAccounts.create_tos_acceptance()

      tos_acceptance
    end

    test "list_tos_acceptances/0 returns all tos_acceptances" do
      tos_acceptance = tos_acceptance_fixture()
      assert StripeAccounts.list_tos_acceptances() == [tos_acceptance]
    end

    test "get_tos_acceptance!/1 returns the tos_acceptance with given id" do
      tos_acceptance = tos_acceptance_fixture()
      assert StripeAccounts.get_tos_acceptance!(tos_acceptance.id) == tos_acceptance
    end

    test "create_tos_acceptance/1 with valid data creates a tos_acceptance" do
      assert {:ok, %TosAcceptance{} = tos_acceptance} = StripeAccounts.create_tos_acceptance(@valid_attrs)
      assert tos_acceptance.date == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_tos_acceptance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.create_tos_acceptance(@invalid_attrs)
    end

    test "update_tos_acceptance/2 with valid data updates the tos_acceptance" do
      tos_acceptance = tos_acceptance_fixture()
      assert {:ok, tos_acceptance} = StripeAccounts.update_tos_acceptance(tos_acceptance, @update_attrs)
      assert %TosAcceptance{} = tos_acceptance
      assert tos_acceptance.date == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_tos_acceptance/2 with invalid data returns error changeset" do
      tos_acceptance = tos_acceptance_fixture()
      assert {:error, %Ecto.Changeset{}} = StripeAccounts.update_tos_acceptance(tos_acceptance, @invalid_attrs)
      assert tos_acceptance == StripeAccounts.get_tos_acceptance!(tos_acceptance.id)
    end

    test "delete_tos_acceptance/1 deletes the tos_acceptance" do
      tos_acceptance = tos_acceptance_fixture()
      assert {:ok, %TosAcceptance{}} = StripeAccounts.delete_tos_acceptance(tos_acceptance)
      assert_raise Ecto.NoResultsError, fn -> StripeAccounts.get_tos_acceptance!(tos_acceptance.id) end
    end

    test "change_tos_acceptance/1 returns a tos_acceptance changeset" do
      tos_acceptance = tos_acceptance_fixture()
      assert %Ecto.Changeset{} = StripeAccounts.change_tos_acceptance(tos_acceptance)
    end
  end
end

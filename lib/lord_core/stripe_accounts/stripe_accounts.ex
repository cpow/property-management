defmodule LordCore.StripeAccounts do
  @moduledoc """
  The StripeAccounts context.
  """

  import Ecto.Query, warn: false
  alias LordCore.Repo

  alias LordCore.StripeAccounts.Account

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{source: %Account{}}

  """
  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end

  alias LordCore.StripeAccounts.ExternalAccount

  @doc """
  Returns the list of external_accounts.

  ## Examples

      iex> list_external_accounts()
      [%ExternalAccount{}, ...]

  """
  def list_external_accounts do
    Repo.all(ExternalAccount)
  end

  @doc """
  Gets a single external_account.

  Raises `Ecto.NoResultsError` if the External account does not exist.

  ## Examples

      iex> get_external_account!(123)
      %ExternalAccount{}

      iex> get_external_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_external_account!(id), do: Repo.get!(ExternalAccount, id)

  @doc """
  Creates a external_account.

  ## Examples

      iex> create_external_account(%{field: value})
      {:ok, %ExternalAccount{}}

      iex> create_external_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_external_account(attrs \\ %{}) do
    %ExternalAccount{}
    |> ExternalAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a external_account.

  ## Examples

      iex> update_external_account(external_account, %{field: new_value})
      {:ok, %ExternalAccount{}}

      iex> update_external_account(external_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_external_account(%ExternalAccount{} = external_account, attrs) do
    external_account
    |> ExternalAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ExternalAccount.

  ## Examples

      iex> delete_external_account(external_account)
      {:ok, %ExternalAccount{}}

      iex> delete_external_account(external_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_external_account(%ExternalAccount{} = external_account) do
    Repo.delete(external_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking external_account changes.

  ## Examples

      iex> change_external_account(external_account)
      %Ecto.Changeset{source: %ExternalAccount{}}

  """
  def change_external_account(%ExternalAccount{} = external_account) do
    ExternalAccount.changeset(external_account, %{})
  end

  alias LordCore.StripeAccounts.LegalEntity

  @doc """
  Returns the list of legal_entities.

  ## Examples

      iex> list_legal_entities()
      [%LegalEntity{}, ...]

  """
  def list_legal_entities do
    Repo.all(LegalEntity)
  end

  @doc """
  Gets a single legal_entity.

  Raises `Ecto.NoResultsError` if the Legal entity does not exist.

  ## Examples

      iex> get_legal_entity!(123)
      %LegalEntity{}

      iex> get_legal_entity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_legal_entity!(id), do: Repo.get!(LegalEntity, id)

  @doc """
  Creates a legal_entity.

  ## Examples

      iex> create_legal_entity(%{field: value})
      {:ok, %LegalEntity{}}

      iex> create_legal_entity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_legal_entity(attrs \\ %{}) do
    %LegalEntity{}
    |> LegalEntity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a legal_entity.

  ## Examples

      iex> update_legal_entity(legal_entity, %{field: new_value})
      {:ok, %LegalEntity{}}

      iex> update_legal_entity(legal_entity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_legal_entity(%LegalEntity{} = legal_entity, attrs) do
    legal_entity
    |> LegalEntity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LegalEntity.

  ## Examples

      iex> delete_legal_entity(legal_entity)
      {:ok, %LegalEntity{}}

      iex> delete_legal_entity(legal_entity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_legal_entity(%LegalEntity{} = legal_entity) do
    Repo.delete(legal_entity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking legal_entity changes.

  ## Examples

      iex> change_legal_entity(legal_entity)
      %Ecto.Changeset{source: %LegalEntity{}}

  """
  def change_legal_entity(%LegalEntity{} = legal_entity) do
    LegalEntity.changeset(legal_entity, %{})
  end

  alias LordCore.StripeAccounts.TosAcceptance

  @doc """
  Returns the list of tos_acceptances.

  ## Examples

      iex> list_tos_acceptances()
      [%TosAcceptance{}, ...]

  """
  def list_tos_acceptances do
    Repo.all(TosAcceptance)
  end

  @doc """
  Gets a single tos_acceptance.

  Raises `Ecto.NoResultsError` if the Tos acceptance does not exist.

  ## Examples

      iex> get_tos_acceptance!(123)
      %TosAcceptance{}

      iex> get_tos_acceptance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tos_acceptance!(id), do: Repo.get!(TosAcceptance, id)

  @doc """
  Creates a tos_acceptance.

  ## Examples

      iex> create_tos_acceptance(%{field: value})
      {:ok, %TosAcceptance{}}

      iex> create_tos_acceptance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tos_acceptance(attrs \\ %{}) do
    %TosAcceptance{}
    |> TosAcceptance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tos_acceptance.

  ## Examples

      iex> update_tos_acceptance(tos_acceptance, %{field: new_value})
      {:ok, %TosAcceptance{}}

      iex> update_tos_acceptance(tos_acceptance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tos_acceptance(%TosAcceptance{} = tos_acceptance, attrs) do
    tos_acceptance
    |> TosAcceptance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TosAcceptance.

  ## Examples

      iex> delete_tos_acceptance(tos_acceptance)
      {:ok, %TosAcceptance{}}

      iex> delete_tos_acceptance(tos_acceptance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tos_acceptance(%TosAcceptance{} = tos_acceptance) do
    Repo.delete(tos_acceptance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tos_acceptance changes.

  ## Examples

      iex> change_tos_acceptance(tos_acceptance)
      %Ecto.Changeset{source: %TosAcceptance{}}

  """
  def change_tos_acceptance(%TosAcceptance{} = tos_acceptance) do
    TosAcceptance.changeset(tos_acceptance, %{})
  end
end

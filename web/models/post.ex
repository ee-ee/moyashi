defmodule Moyashi.Post do
  use Moyashi.Web, :model

  schema "posts" do
    field :name, :string, default: "Anonymous"
    field :email, :string
    field :body, :string
    field :attach, :string
    field :thumb, :string
    field :parent_id, :integer, default: nil
    field :bumped_at, Ecto.DateTime, default: Ecto.DateTime.utc
    belongs_to :board, Moyashi.Board

    timestamps
  end

  @required_fields ~w(body)
  @optional_fields ~w(name email parent_id attach bumped_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:body, min: 1, max: 1024)
  end

  def format_date(date) do
    {:ok, date} = Ecto.DateTime.dump(date)
    Timex.Date.from(date)
    |> Timex.DateFormat.format!("%H:%M %d/%m/%y", :strftime)
  end
end
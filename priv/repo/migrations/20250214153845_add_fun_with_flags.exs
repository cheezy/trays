defmodule Trays.Repo.Migrations.AddFunWithFlags do
  use Ecto.Migration

  def change do
    create table(:fun_with_flags_toggles, primary_key: false) do
      add :id, :bigserial, primary_key: true
      # If you configure :ecto_primary_key_type to be :binary_id, you should replace
      # the line above with:
      # add :id, :binary_id, primary_key: true
      add :flag_name, :string, null: false
      add :gate_type, :string, null: false
      add :target, :string, null: false
      add :enabled, :boolean, null: false
    end

    create index(
             :fun_with_flags_toggles,
             [:flag_name, :gate_type, :target],
             unique: true,
             name: "fwf_flag_name_gate_target_idx"
           )
  end
end

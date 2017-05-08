class CreateDivisions < ActiveRecord::Migration[5.1]
  def change
    create_table(:divisions) do |t|
      t.column(:name, :string)
    end
  end
end

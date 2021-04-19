class AddAuthorToEmployees < ActiveRecord::Migration[5.2]
  def change
    #add_reference :interventions, :author, references: :employee, index: true
    add_foreign_key :interventions, :employees, column: :author
  end
end

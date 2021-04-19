class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.string :start_interv
      t.string :stop_interv
      t.string :result
      t.string :reports
      t.string :status
      t.string :employee_id
      t.bigint :author

      t.timestamps
    end
  end
end

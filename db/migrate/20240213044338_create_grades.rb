class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.string :subject_name
      t.string :subject_number
      t.string :unit_count
      t.string :overall_evaluation

      t.timestamps
    end
  end
end

class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      # This will create an integer field in the answers table named question_id
      # the foreign_key: true will add a foreign key constraint to the database
      # the index: true will add an index on the question_id field for answers
      # table.
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

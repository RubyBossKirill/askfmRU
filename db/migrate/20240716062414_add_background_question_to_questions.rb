class AddBackgroundQuestionToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :background_color, :string
  end
end

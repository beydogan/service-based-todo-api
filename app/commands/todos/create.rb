module Todos
  class Create < ::ApplicationCommand

    required do
      string :title
      string :deadline
    end

    def execute
      todo = Todo.create!(title: title, deadline: deadline)

      # Add Callbacks here

      todo
    end
  end
end
module Todos
  class Update < ::ApplicationCommand

    required do
      integer :id
    end

    optional do
      string :title
      string :deadline
    end

    def execute
      todo = Todo.find(id)
      todo.update!(title: title, deadline: deadline)

      # Add Callbacks here

      todo
    end
  end
end
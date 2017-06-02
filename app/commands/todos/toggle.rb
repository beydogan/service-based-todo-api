module Todos
  class Toggle < ::ApplicationCommand

    required do
      integer :id
    end

    def execute
      todo = Todo.find(id)
      todo.update!(completed: !todo.completed)

      # Add Callbacks here

      todo
    end
  end
end
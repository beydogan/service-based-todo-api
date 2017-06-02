module Todos
  class Index < ::ApplicationCommand

    def execute
      Todo.all
    end
  end
end
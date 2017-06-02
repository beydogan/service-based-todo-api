module Todos
  class Update < ::ApplicationCommand

    required do
      string :title
      string :deadline
    end

    def execute
      "1"
    end
  end
end
class ApplicationCommand < Mutations::Command
  def self.allowed_params
    self.input_filters.required_inputs.keys + self.input_filters.optional_inputs.keys
  end
end

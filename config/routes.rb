Rails.application.routes.draw do

  match "api/call/:namespace/:command", to: "api/api#call", via: [:get, :post, :put, :delete]
end

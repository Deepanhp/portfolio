Rails.application.routes.draw do
  # Define root path
  root "home#index"

  # Named routes for all pages
  get "/about", to: "home#about", as: :about
  get "/projects", to: "home#projects", as: :projects
  get "/contact", to: "home#contact", as: :contact
  get "/surprise", to: "home#surprise", as: :surprise
  get "/download_resume", to: "home#download_resume"

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check
end

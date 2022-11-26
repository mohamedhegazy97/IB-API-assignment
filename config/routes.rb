Rails.application.routes.draw do
  resources :messages
  post "/applications", to: "applications#create"
  get "/applications/:token", to: "applications#show"
  patch "/applications/:token" ,to: "applications#update"
  get "/applications/:AppToken/chats", to: "chats#index"
  get "/applications/:AppToken/chats/:number" ,to: "chats#show"
  post "/applications/:AppToken/chats", to: "chats#create"
  post "/applications/:AppToken/chats/:number" ,to: "messages#create"
  get "/applications/:AppToken/chats/:number/messages" ,to: "messages#index"
  get "/applications/:AppToken/chats/:number/search" ,to: "messages#search"
  patch "/applications/:AppToken/chats/:chat_number/messages/:number" ,to: "messages#update"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

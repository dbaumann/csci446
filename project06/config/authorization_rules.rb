authorization do
  role :admin do
    has_permission_on [:roles, :users, :games], :to => [:index, :show, :new, :create, :edit, :update, :delete]
  end
end

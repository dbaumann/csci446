authorization do
  role :guest do
    has_permission_on :games, :to => [:index]
    has_permission_on :users, :to => [:new, :create]
    has_permission_on :user_sessions, :to => [:new, :create, :destroy]
  end
  role :admin do
    has_permission_on [:games, :users, :user_sessions], :to => :everything
    has_permission_on [:admin_admin, :admin_games, :admin_roles, :admin_users], :to => :everything
  end
end
  
privileges do
    privilege :everything, :includes => [:index, :show, :new, :create, :edit, :update, :destroy]
end

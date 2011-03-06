authorization do
  role :guest do
    has_permission_on :user_sessions, :to => [:new, :create]
    has_permission_on :games, :to => [:index]
    has_permission_on :users, :to => [:new, :create]
  end
  role :member do
    has_permission_on :user_sessions, :to => [:destroy]
    has_permission_on :members_members, :to => :index
    has_permission_on :members_games, :to => [:index, :new, :create]
    has_permission_on :members_games, :to => [:edit, :update] do
      if_attribute :user => is { user }
    end
    has_permission_on :members_users, :to => [:edit, :update]
  end
  role :admin do
    has_permission_on :user_sessions, :to => [:destroy]
    has_permission_on :admin_admin, :to => :index
    has_permission_on [:admin_games, :admin_roles, :admin_users], :to => :everything
  end
end

privileges do
    privilege :everything,
      :includes => [:index, :show, :new, :create, :edit, :update, :destroy]
end

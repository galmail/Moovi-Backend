ActiveAdmin.register Group do
  
  
  show do |g|
    attributes_table do
      row :id
      row :name
      g.users.each{ |u|
        row :participant do
          link_to(u.name, admin_user_path(u.id))
        end
      }
    end
  end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end

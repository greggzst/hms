include ActiveAdminHelper

ActiveAdmin.register Photo do
  actions :index, :destroy, :show

  member_action :switch_primary, method: :patch do
    if request.xhr?
      if resource.is_primary
        resource.unset_primary
      else
        resource.set_primary
      end

      render json: { label: "#{resource.is_primary ? 'TAK' : 'NIE'}", class: "#{resource.is_primary ? 'yes' : 'no'}" }
    end
  end

  index do
    id_column
    column :room
    column :image do |p|
      image_tag(p.image_url(:thumb))
    end
    column :is_primary do |photo|
      switch_link(switch_primary_admin_photo_path(photo), photo, :is_primary)
    end
    actions
  end

  show do
    attributes_table do
      row :image do |p|
        image_tag(p.image_url(:preview))
      end
      row :room
      row :is_primary
    end
  end
end
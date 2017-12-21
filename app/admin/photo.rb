include ActiveAdminHelper

ActiveAdmin.register Photo do
  actions :index, :destroy, :show

  member_action :switch_primary, method: :patch do
    if request.xhr?
      photos = []
      if resource.is_primary
        resource.unset_primary
      else
        room_primary_photo = resource.room.primary_photo
        if room_primary_photo
          room_primary_photo.unset_primary
          photos << { photo_id: room_primary_photo.id, label: 'NO', class: 'no' }
        end
        resource.set_primary
      end

      photos << { label: "#{resource.is_primary ? 'YES' : 'NO'}", class: "#{resource.is_primary ? 'yes' : 'no'}" }

      render json: photos
    end
  end

  index do
    selectable_column
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
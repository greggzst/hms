ActiveAdmin.register Reservation do
  permit_params :is_cancelled, reservation_services_attributes: [:id, :service_id, :amount]
  actions :all, except: [:destroy]

  filter :user, as: :select, collection: proc { User.distinct.pluck :email, :id }
  filter :start_date
  filter :end_date
  filter :is_cancelled
  filter :created_at

  index do
    id_column
    column :user
    column :start_date do |r|
      r.start_date.strftime('%d/%m/%Y')
    end

    column :end_date do |r|
      r.end_date.strftime('%d/%m/%Y')
    end

    column :rooms do |r|
      rooms_count = r.rooms.count
      rooms_ids = r.rooms.map(&:id)
      link_to rooms_count, admin_rooms_path("q[id_in]" => rooms_ids)
    end

    column :services do |r|
      services = r.reservation_services.reject{|rs| rs.amount.zero?}
      services_count = services.count
      services_ids = services.map{|rs| rs.service.id}
      link_to services_count, admin_services_path("q[id_in]" => services_ids)
    end

    column :is_cancelled

    column :costs do |r|
      number_to_currency(r.costs)
    end

    column :created_at
    actions
  end

  show do
    attributes_table do
      row :user
      row :start_date do |r|
        r.start_date.strftime('%d/%m/%Y')
      end

      row :end_date do |r|
        r.end_date.strftime('%d/%m/%Y')
      end

      row :rooms do |r|
        rooms_list_items = r.rooms.map{|r| content_tag(:li, link_to(r.name, admin_room_path(id: r.id)))}.join.html_safe
        content_tag(:ul) do
          rooms_list_items
        end
      end

      row :services do |r|
        services = r.reservation_services.reject{|rs| rs.amount.zero?}
        if services.any?
          services_list_items = services.map{
            |rs| content_tag(:li, link_to("#{rs.service.name} x #{rs.amount}", admin_service_path(id: rs.service.id)))
          }.join.html_safe
          content_tag(:ul) do
            services_list_items
          end
        else
          "EMPTY"
        end
      end

      row :is_cancelled

      row :costs do |r|
        number_to_currency(r.costs)
      end

      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.has_many :reservation_services, new_record: false do |rs|
        rs.input :id, as: :hidden
        rs.input :service_id, as: :hidden
        rs.input :amount, label: rs.object.service.name
      end
      f.input :is_cancelled
    end
    f.actions
  end

end

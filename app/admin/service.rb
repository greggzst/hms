ActiveAdmin.register Service do
  permit_params :name, :price, :availability

  filter :name
  filter :price
  filter :availability, as: :select, collection: proc { Service.availabilities.map{|k,v| [k, v]} }

  index do
    column :name
    column :price do |s|
      number_to_currency(s.price)
    end
    column :availability
    actions
  end

  show do
    attributes_table do
      row :name
      row :price do |s|
        number_to_currency(s.price)
      end
      row :availability
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :availability, as: :select, collection: Service.availabilities.keys
    end
    f.actions
  end


end

ActiveAdmin.register User do
  actions :all, except: [:edit, :update, :destroy]

  filter :email
  filter :has_account
  filter :firstname
  filter :lastname
  filter :valid_document_number

  index do
    id_column
    column :email
    column :has_account
    column :firstname
    column :lastname
    column :valid_document_number
    actions
  end

  show do
    attributes_table do
      row :email
      row :has_account
      row :firstname
      row :lastname
      row :valid_document_number
    end
  end
end
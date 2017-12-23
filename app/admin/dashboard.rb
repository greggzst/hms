ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel '5 recent reservations' do
          table_for Reservation.order(created_at: :desc).limit(5) do |r|
            r.column('ID') { |r| link_to r.id, admin_reservation_path(r)}
            r.column('Reservation Date') { |r| r.created_at.strftime('%d/%m/%Y')}
            r.column('Start Date') { |r| r.start_date.strftime('%d/%m/%Y')}
            r.column('End Date') { |r| r.end_date.strftime('%d/%m/%Y')}
            r.column('User') { |r| link_to r.user.email, admin_user_path(r.user)}
          end
        end
      end
    end
  end
end

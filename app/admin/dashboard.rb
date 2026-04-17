ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Bookings' do
          table_for Order.order(created_at: :desc).limit(10) do
            column :id
            column :user
            column :total
            column :status
            column :created_at
          end
        end
      end

      column do
        panel 'Site Stats' do
          para "Total Rooms: #{Room.count}"
          para "Total Users: #{User.count}"
          para "Total Bookings: #{Order.count}"
          para "Total Revenue: $#{Order.sum(:total).round(2)}"
        end
      end
    end
  end
end

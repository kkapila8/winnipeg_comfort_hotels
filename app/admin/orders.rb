ActiveAdmin.register Order do
  actions :all, except: [:new, :create, :destroy]

  permit_params :status

  index do
    selectable_column
    id_column
    column :user
    column :province_name
    column :subtotal
    column :total
    column :status
    column :created_at
    actions
  end

  filter :status
  filter :user
  filter :created_at

  show do
    attributes_table do
      row :id
      row :user
      row :province_name
      row :shipping_address
      row :shipping_city
      row :shipping_postal
      row :subtotal
      row :gst_amount
      row :pst_amount
      row :hst_amount
      row :total
      row :status
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :room_name
        column :unit_price
        column :quantity
        column :line_total
      end
    end
  end

  form do |f|
    f.inputs "Update Order" do
      f.input :status, as: :select, collection: Order::STATUSES
    end
    f.actions
  end
end
ActiveAdmin.register Room do
  permit_params :name, :room_type, :price, :sale_price, :capacity,
                :description, :amenities, :available, :on_sale,
                :hotel_id, :image, category_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :room_type
    column :hotel
    column :price
    column :on_sale
    column :available
    column :image do |room|
      if room.image.attached?
        image_tag room.image.variant(resize_to_fill: [80, 60]), style: 'border-radius:4px;'
      else
        'No image'
      end
    end
    actions
  end

  filter :name
  filter :room_type
  filter :hotel
  filter :on_sale
  filter :available

  show do
    attributes_table do
      row :name
      row :room_type
      row :hotel
      row :price
      row :sale_price
      row :capacity
      row :description
      row :amenities
      row :available
      row :on_sale
      row :image do |room|
        if room.image.attached?
          image_tag room.image.variant(resize_to_fill: [300, 200])
        else
          'No image uploaded'
        end
      end
    end
  end

  form do |f|
    f.inputs 'Room Details' do
      f.input :hotel
      f.input :name
      f.input :room_type, as: :select, collection: Room::ROOM_TYPES
      f.input :price, min: 0.01
      f.input :sale_price, min: 0.01
      f.input :capacity, min: 1
      f.input :description
      f.input :amenities, hint: 'Comma separated e.g. Free WiFi, TV, Mini Bar'
      f.input :available
      f.input :on_sale
      f.input :categories, as: :check_boxes
      f.input :image, as: :file, hint: 'Upload a room image'
    end
    f.actions
  end
end

ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  index do
    selectable_column
    id_column
    column :slug
    column :title
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Page Content' do
      f.input :slug, as: :select, collection: %w[about contact]
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end
end

ActiveAdmin.register Province do
  actions :all, except: %i[new create destroy]

  permit_params :gst, :pst, :hst

  index do
    selectable_column
    id_column
    column :name
    column :code
    column('GST') { |p| "#{(p.gst * 100).round(2)}%" }
    column('PST') { |p| "#{(p.pst * 100).round(2)}%" }
    column('HST') { |p| "#{(p.hst * 100).round(2)}%" }
    column('Tax Summary') { |p| p.tax_summary }
    actions
  end

  filter :name
  filter :code

  show do
    attributes_table do
      row :name
      row :code
      row('GST') { |p| "#{(p.gst * 100).round(2)}%" }
      row('PST') { |p| "#{(p.pst * 100).round(2)}%" }
      row('HST') { |p| "#{(p.hst * 100).round(2)}%" }
      row('Tax Summary') { |p| p.tax_summary }
    end
  end

  form do |f|
    f.inputs 'Update Tax Rates' do
      f.input :name, input_html: { disabled: true }
      f.input :code, input_html: { disabled: true }
      f.input :gst, label: 'GST Rate (decimal e.g. 0.05 = 5%)', min: 0, max: 1, step: 0.001
      f.input :pst, label: 'PST Rate (decimal e.g. 0.07 = 7%)', min: 0, max: 1, step: 0.001
      f.input :hst, label: 'HST Rate (decimal e.g. 0.15 = 15%)', min: 0, max: 1, step: 0.001
    end
    f.actions
  end
end
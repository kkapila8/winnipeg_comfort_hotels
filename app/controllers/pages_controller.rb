class PagesController < ApplicationController
  def about
    @page = Page.find_by(slug: "about")
    @breadcrumbs = [
      { name: "Home", path: root_path },
      { name: "About Us", path: nil }
    ]
  end

  def contact
    @page = Page.find_by(slug: "contact")
    @breadcrumbs = [
      { name: "Home", path: root_path },
      { name: "Contact", path: nil }
    ]
  end
end
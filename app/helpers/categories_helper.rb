module CategoriesHelper
  def render_category_html(category)
    render :partial => 'admin/categories/category', :locals => { :category => category }
  end
end
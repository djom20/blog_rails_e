module ArticlesHelper
	def category_links(categories)
    links = categories.collect{|c| link_to c.name, category_path(c)}
    return links.join(", ").html_safe
  end
end
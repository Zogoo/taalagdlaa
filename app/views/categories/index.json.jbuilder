json.total @categories.count
json.categories @categories do |category|
  json.partial! 'categories/category', category: category
end

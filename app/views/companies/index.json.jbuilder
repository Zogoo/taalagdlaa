json.total @companies.count
json.companies @companies do |company|
  json.partial! 'companies/company', company: company
end

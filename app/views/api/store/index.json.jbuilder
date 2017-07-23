json.stores do
  json.array! @stores do |store|
    json.id  store.id
    json.name store.name
    json.lat   store.lat
    json.lon   store.lon
    json.description  store.description
    json.items store.store_discounts
  end
end
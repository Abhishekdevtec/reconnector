# See https://partner.realestate.com.au/documentation/api/listings/specifications/#functional-elements

xml.instruct!
xml.propertyList(date: Time.now.to_s) do
  xml.category
  xml.name @property.name
  # xml.quantity(@property.quantity, type: 'integer')
  # xml.category @property.category.name
end
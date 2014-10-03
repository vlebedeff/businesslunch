collection @orders

attributes :id, :state, :created_on

node :menu_set do |order|
  {
    name: order.menu_set.name,
    details: order.menu_set.details
  }
end

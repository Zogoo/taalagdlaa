FactoryBot.define do
  factory :category do
    name do
      [
        'beauty salon',
        'car repair',
        'car wash',
        'bowling',
        'golf',
        'school',
        'photography',
        'hostpital',
        'clinic',
        'hotel',
        'motel',
        'car parking',
        'fitness',
        'restaurant',
        'museum',
        'bank',
        'theatre',
        'retailer',
        'amusement park',
        'food manufactor',
        'cloth manufactor',
        'people',
        'service',
        'building'
      ].sample
    end
  end
end

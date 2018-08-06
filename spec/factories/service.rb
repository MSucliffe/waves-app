FactoryBot.define do
  factory :service do
    standard_days 10
    premium_days 3
  end

  factory :demo_service, parent: :service do
    name "Demo Service"
    standard_days 10
    premium_days 1
    part_1 { { standard: 124, premium: 180, subsequent: 99 } }
    part_3 { { standard: 25, premium: 50 } }
    part_4 { { standard: 124, premium: 180 } }
    rules { [:validates_on_approval] }
  end

  factory :subsequent_only_service, parent: :service do
    name "Subsequent Service"
    standard_days 10
    part_3 { { subsequent: 15 } }
  end

  factory :standard_only_service, parent: :service do
    standard_days 10
    part_3 { { standard: 99 } }
  end
end

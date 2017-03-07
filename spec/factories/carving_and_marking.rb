FactoryGirl.define do
  factory :carving_and_marking do
    submission      { build(:submission) }
    tonnage_type    { [:net_tonnage, :register_tonnage].sample }
    actioned_by       { build(:user) }
    template        { CarvingAndMarking::TEMPLATES.sample[1] }
  end

  factory :emailable_carving_and_marking, parent: :carving_and_marking do
    delivery_method :email
  end

  factory :printable_carving_and_marking, parent: :carving_and_marking do
    delivery_method :print
  end
end

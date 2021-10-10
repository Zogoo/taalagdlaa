require 'rails_helper'

RSpec.describe Company, type: :model do
  let!(:company) do
    create(:company, name: 'BornersWagonBuilder', label: 'BornersWagonBuilder',
                     tags: { name: %w[builder wagon borner bornerwagon] })
  end

  describe 'create' do
    context 'when name and label has capital letters' do
      it 'will convert name to down case' do
        expect(company.name).to eq('bornerswagonbuilder')
      end

      it 'will not convert label to down case' do
        expect(company.label).to eq('BornersWagonBuilder')
      end
    end
  end

  describe 'search' do
    context 'when search by name' do
      it 'will search by part of name' do
        expect(Company.by_name('wagon').first.name).to eq('bornerswagonbuilder')
        expect(Company.by_name('builder').first.name).to eq('bornerswagonbuilder')
        expect(Company.by_name('borner').first.name).to eq('bornerswagonbuilder')
      end
    end

    context 'when search by tags' do
      it 'will allow you search by JSON array' do
        expect(Company.by_tags(name: %w[wagon builder]).first.name).to eq('bornerswagonbuilder')
      end
    end
  end
end

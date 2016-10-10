require "rails_helper"

describe CoverLetter do
  context "for a single registration" do
    before { create_printing_submission! }

    let(:cover_letter) { CoverLetter.new(Registration.last) }

    it "has a filename" do
      expect(cover_letter.filename)
        .to match(/celebrator-doppelbock-cover-letter-.*\.pdf/)
    end
  end

  context "for multiple registrations" do
    before do
      3.times { create_printing_submission! }
    end

    let(:cover_letter) { CoverLetter.new(Registration.all) }

    it "has a filename" do
      expect(cover_letter.filename)
        .to eq("cover-letters.pdf")
    end

    it "has three pages with the vessel name on each" do
      PDF::Reader.open(StringIO.new(cover_letter.render)) do |reader|
        expect(reader.page_count).to eq(3)
        expect(reader.page(1).text).to match(/CELEBRATOR/)
        expect(reader.page(2).text).to match(/CELEBRATOR/)
        expect(reader.page(3).text).to match(/CELEBRATOR/)
      end
    end
  end
end

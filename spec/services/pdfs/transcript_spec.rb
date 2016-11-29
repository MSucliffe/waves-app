require "rails_helper"

describe Pdfs::Transcript do
  let(:transcript_title) { "TRANSCRIPT OF REGISTRY" }

  xcontext "for a single transcript" do
    before do
      vessel = create(:registered_vessel)
      create(
        :registration,
        registry_info: vessel.registry_info,
        vessel_id: vessel.id, registered_at: "2012-12-03")
    end

    let(:transcript) { described_class.new(Registration.last) }

    it "has a filename" do
      expect(transcript.filename)
        .to match(/boaty-mcboatfac.*\-transcript-.*\.pdf/)
    end

    it "has two pages with the title on page 1" do
      PDF::Reader.open(StringIO.new(transcript.render)) do |reader|
        expect(reader.page_count).to eq(2)
        expect(reader.page(1).text).to have_text(transcript_title)
      end
    end
  end

  xcontext "for multiple transcripts" do
    before do
      3.times do
        vessel = create(:registered_vessel)
        create(
          :registration,
          registry_info: vessel.registry_info,
          vessel_id: vessel.id, registered_at: "2012-12-03")
      end
    end

    let(:transcript) { described_class.new(Registration.all) }

    it "has a filename" do
      expect(transcript.filename)
        .to eq("transcripts.pdf")
    end

    it "has six pages with the title on page 1,3,5" do
      PDF::Reader.open(StringIO.new(transcript.render)) do |reader|
        expect(reader.page_count).to eq(6)
        expect(reader.page(1).text).to have_text(transcript_title)
        expect(reader.page(3).text).to match(transcript_title)
        expect(reader.page(5).text).to match(transcript_title)
      end
    end
  end
end
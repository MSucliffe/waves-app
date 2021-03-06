#rubocop:disable all
class Pdfs::CarvingAndMarking::Under24m< Pdfs::CarvingAndMarking::Base
  private

  def title_text
    "PLEASURE VESSELS UNDER 24 METRES"
  end

  def draw_vessel
    set_copy_font
    @pdf.bounding_box([lmargin, 645], width: 510) { @pdf.stroke_horizontal_rule }
    @pdf.draw_text "VESSEL NAME", at: [lmargin, 625]
    @pdf.draw_text "OFFICIAL NUMBER", at: [lmargin, 600]
    @pdf.draw_text "PORT OF CHOICE", at: [lmargin, 575]
    @pdf.draw_text @carving_and_marking_note.tonnage_label, at: [lmargin, 550]

    set_bold_font
    @pdf.draw_text @vessel.name, at: [300, 625]
    @pdf.draw_text @submission.vessel_reg_no, at: [300, 600]
    @pdf.draw_text @vessel.port_name, at: [300, 575]
    @pdf.draw_text @carving_and_marking_note.tonnage_value, at: [300, 550]

    @pdf.bounding_box([lmargin, 530], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_marking_notes
    set_copy_font
    @pdf.draw_text "The above vessel is to be marked with the following:", at: [lmargin, 510]
    @pdf.draw_text "- the official number and its appropriate tonnage are to be permanently and conspicuously", at: [lmargin + 20, 495]
    @pdf.draw_text "carved or marked", at: [lmargin + 30, 480]
    @pdf.draw_text "- the name is to be marked on each of its bows and its stern", at: [lmargin + 20, 465]
    @pdf.draw_text "- the port of choice is to be marked on its stern in the manner prescribed over", at: [lmargin + 20, 450]
    @pdf.draw_text "If you are claiming exemption from the usual marking you should tick here [   ] and mark", at: [lmargin, 425]
    @pdf.draw_text "the vessel in accordance with the relevant exemption.", at: [lmargin, 410]
    @pdf.bounding_box([lmargin, 390], width: 510) { @pdf.stroke_horizontal_rule }
  end

  def draw_instructions
    @pdf.font("Helvetica", size: 11)
    vpos = 760
    spacer = 18
    @pdf.draw_text "A pleasure vessel which is under 24 metres in length is to be marked as:", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "(a) the official number and registered tonnage are:", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "(i) to be marked on the main beam or, if there is no main beam, on a readily accessible ", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "visible permanent part of the structure of the pleasure vessel,either by cutting in, ", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "centre-punching of raised lettering or", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "(ii) to be engraved on plates of metal, wood or plastic, secured to the main beam or, if there", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text " is no main beam, to a readily accessible visible part of the structure with rivets, through bolts", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "with the ends clenched, or screws with the slots removed;", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "(b) the name and port of choice (unless an exempted ship), are to be permanently marked on a", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "conspicuous and permanent part of the stern on a dark groun in white or yellow letters, or on a ", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "light ground  in black letters, the letters not being less than 5 centimetres high and of proportionate", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "breadth, or, where this is not possible, by the alternative methods given below:", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "(i) by engraving on plates of metal or plastic or by cutting in on a shaped wooden chock.", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "Where a wooden chock is used it should be secured to the hull through bolts, the ends", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "being clenched, or", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "(ii) by individual reinforced plastic letters and numbers approximately 2mm in", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "thickness. These to be fixed to the hull with epoxy adhesive, and painted with", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "suitable paint and coated with translucent epoxy resin;", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "(iii) where metal or plastic plates have been used these must be fixed by the use of", at: [lmargin + 25, vpos]
    vpos -= spacer
    @pdf.draw_text "epoxy adhesives. Metal of plastic plates secured by adhesives should be coated with", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "translucent epoxy resin after they have been fixed in a position.", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.draw_text "", at: [lmargin + 35, vpos]
    vpos -= spacer
    @pdf.font("Helvetica", size: 12)
    @pdf.draw_text "IMO NUMBER   #{@vessel.imo_number}        #{@carving_and_marking_note.tonnage_description}", at: [lmargin + 100, vpos]
    @pdf.font("Helvetica", size: 10)
    vpos -= spacer + 100
    @pdf.font("Helvetica-Bold", size: 11)
    @pdf.draw_text "Exemptions", at: [lmargin, vpos]
    vpos -= spacer
    @pdf.draw_text "Please vessels owned by members of exempted yacht clubs are not require to ", at: [lmargin + 10, vpos]
    vpos -= spacer
    @pdf.draw_text "have their ports of choice marked on their sterns.", at: [lmargin + 10, vpos]
  end
end
# rubocop:enable all

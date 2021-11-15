class DimTime < SecondBase::Base
  def self.buildDimension(id, form_type)
    if form_type == "quote"
      form = Quote.find(id)
    elsif form_type == "contact"
      form = Lead.find(id)
    end
    dimension = DimTime.new
    dimension.year = form.created_at.year
    dimension.month = form.created_at.month
    dimension.day = form.created_at.day
    dimension.form_type = form_type
    dimension.save
    return dimension.id
  end
end

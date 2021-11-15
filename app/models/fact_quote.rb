class FactQuote < SecondBase::Base

  def self.getQuotesData
    quotes = Quote.where({ created_at: (Time.now - 25.hour)..Time.now })
    quotes.each do |quote|
      fact = FactQuote.find_or_create_by(QuoteId: quote.id)
      fact.Creation_Date = quote.created_at
      fact.Company_Name = quote.company_name#
      fact.Email = quote.company_email#
      fact.NbElevator = quote.amount_of_elevator
      if fact.dim_time_id == nil
        fact.dim_time_id = DimTime.buildDimension(fact.QuoteId, "quote")
      end
      fact.save
    end
  end
end

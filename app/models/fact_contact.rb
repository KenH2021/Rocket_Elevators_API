class FactContact < SecondBase::Base
  def self.getContactsData
    contacts = Lead.where({ created_at: (Time.now - 25.hour)..Time.now })
    
    contacts.each do |contact|
      fact = FactContact.find_or_create_by(ContactId: contact.id)
      fact.Creation_Date = contact.created_at
      fact.Company_Name = contact.company_name
      fact.Email = contact.email
      fact.Project_Name = contact.project_name
      if fact.dim_time_id == nil
        fact.dim_time_id = DimTime.buildDimension(fact.ContactId, "contact")  
      end
      fact.save
    end
  end
end

module LeadsHelper
  def getLeadName(id)
    begin
      lead = Lead.find(id)
      lead.firstname + " " + lead.lastname
    rescue
      []
    end
  end

  def getLeadEmail(id)
    begin
      lead = Lead.find(id)
      lead.email
    rescue
      []
    end
  end

  def getLeadRegion(id)
    begin
      lead = Lead.find(id)
      lead.town
    rescue
      []
    end
  end
end

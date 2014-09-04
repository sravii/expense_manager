module ApplicationHelper
	
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Expense Manager"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def human_datetime(date)
    date.strftime("%B #{date.day.ordinalize}, %Y at %I:%M %p")
  end

  def human_date(date)
    if(date)
      date.strftime("%B #{date.day.ordinalize}, %Y")
    else
      ""
    end
  end
  
end

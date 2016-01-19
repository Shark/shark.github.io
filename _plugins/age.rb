module Jekyll
  class AgeTag < Liquid::Tag
    def render(context)
      birthday = Date.parse('1992-05-18')
      today = Date.today
      age_in_completed_years(birthday, today)
    end

    private

    # https://stackoverflow.com/questions/1904097/how-to-calculate-how-many-years-passed-since-a-given-date-in-ruby
    def age_in_completed_years (bd, d)
      # Difference in years, less one if you have not had a birthday this year.
      a = d.year - bd.year
      a = a - 1 if (
           bd.month >  d.month or
          (bd.month >= d.month and bd.day > d.day)
      )
      a
    end
  end
end

Liquid::Template.register_tag('age', Jekyll::AgeTag)

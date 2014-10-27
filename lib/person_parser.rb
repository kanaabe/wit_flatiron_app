class PersonParser

  def self.parse
    doc = Nokogiri::HTML(open("http://ruby006.students.flatironschool.com/"))

    doc.css('li.home-blog-post').each do |student|
      name = student.search('.big-comment a').text.strip.chomp
      quote = student.search('.home-blog-post-meta').text.strip.chomp
      url = student.search('.big-comment a').attribute('href').to_s
      #binding.pry
      
      person = Profile.new
      person.name = name
      person.quote = quote

      student_data = Nokogiri::HTML(open("http://ruby006.students.flatironschool.com/#{url}"))

      biography = student_data.search('.services')[0].search('p').text.strip.chomp
      education = student_data.search('.services')[1].search('li').text.strip.chomp
      work = student_data.search('.services')[2].search('p').text.strip.chomp
      relative_image_url = student_data.search('.top-page-title div img').attribute('src').to_s
      absolute_image_url = relative_image_url.gsub(/\.\.\//, '')
      
      if name == 'Robyn Trovati'
        linkedin = "https://www.linkedin.com/pub/robyn-trovati/8a/50/225"
        github = "https://github.com/robyntrovati"
        twitter = "" 
      else

        twitter = student_data.search('.social-icons').children[1]["href"]
        github = student_data.search('.social-icons').children[5]["href"]
        linkedin = student_data.search('.social-icons').children[3]["href"]
      end

      person.github = github
      person.linkedin = linkedin
      person.twitter = twitter
      person.biography = biography
      person.education = education
      person.work = work
      person.img_url = absolute_image_url
      person.save
    end
  end

end

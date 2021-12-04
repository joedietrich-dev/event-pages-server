require 'faker'

puts "=== SEEDING START ==="
# Create Event Sponsor Levels
sponsor_levels = [
  EventSponsorLevel.create(name: "Partners", rank: 0), 
  EventSponsorLevel.create(name: "Creative Partners", rank: 1), 
  EventSponsorLevel.create(name: "Sponsoring Partners", rank: 2), 
  EventSponsorLevel.create(name: "Sponsors", rank: 3), 
  EventSponsorLevel.create(name: "Supporting Sponsors", rank: 4), 
  EventSponsorLevel.create(name: "Presenting Sponsors", rank: 5)
]

# Create Sponsors
sponsors = []
50.times do |i|
  sponsor = Sponsor.create(name: Faker::Company.name, logo_src: "https://joedietrich.dev/imagestore/logos/logoipsum-logo-#{i + 1}.svg")
  sponsors << sponsor
end

# Create Panelists
panelists = []
50.times do |i|
  panelist = Panelist.create(
    name: Faker::Name.name, 
    title: Faker::Job.title,
    company: "#{Faker::Company.name} #{Faker::Company.suffix}",
    bio: "#{Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)}\n#{Faker::Lorem.paragraph(sentence_count: 3, supplemental: false, random_sentences_to_add: 3)}\n#{Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 2)}",
    headshot_src: "http://placebeard.it/480/640?random=#{i}"
  )
  panelists << panelist
end

# Create Events
5.times do
  title = "#{Faker::Number.between(from: 2021, to: 2025)} #{Faker::Nation.nationality.singularize} #{Faker::Hobby.activity} Show"
  event = Event.create(
    title: title,
    description: Faker::Hipster.sentences.join(" "),
    short_description: Faker::GreekPhilosophers.quote,
    location: Faker::Address.full_address,
    hero_src: "https://placeimg.com/1000/500/tech?random=#{rand(1..20)}",
    register_link: "http://example.com/#{title.parameterize}/register",
    view_link: "http://example.com/#{title.parameterize}/view",
    date: Faker::Date.between(from: Date.today, to: 4.year.from_now)
  )

  # Create Event Sponsors
  EventSponsor.create(
    event_sponsor_level: sponsor_levels[0],
    order: 0,
    event: event,
    sponsor: sponsors.sample
  )

  4.times do |level|
    rand(0..3).times do |i|
      EventSponsor.create(
        event_sponsor_level: sponsor_levels[level + 1],
        order: i,
        event: event,
        sponsor: sponsors.sample
      )
    end
  end

  2.times do |level|
    rand(0..4).times do |i|
      EventSponsor.create(
        event_sponsor_level: sponsor_levels[level + 3],
        order: i,
        event: event,
        sponsor: sponsors.sample
      )
    end
  end

  # Create Honorees
  rand(1..4).times do |i|
    Honoree.create(
      honor: "#{Faker::Commerce.material} Award", 
      name: Faker::Name.name, 
      descriptor: "#{Faker::Job.seniority} #{Faker::Job.position}",
      bio: "#{Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)}\n#{Faker::Lorem.paragraph(sentence_count: 3, supplemental: false, random_sentences_to_add: 3)}\n#{Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 2)}",
      img_src: "https://placeimg.com/480/640?random=#{i + 90}",
      event: event
    )
  end

  # Create Hosts
  rand(1..2).times do |i|
    Host.create(
      name: Faker::Name.name, 
      bio: "#{Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)}\n#{Faker::Lorem.paragraph(sentence_count: 3, supplemental: false, random_sentences_to_add: 3)}\n#{Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 2)}",
      headshot_src: "http://placebeard.it/480/640?random=#{i + 700}",
      event: event
    )
  end

  # Create Panels
  rand(2..8).times do |i|
    panel = Panel.create(
      title: Faker::Marketing.buzzwords,
      description: Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 4),
      time: Time.parse("#{event.date}") + 60 * 60 * 10 + 60 * 30 * i,
      event: event,
      panelists: panelists.sample(rand(2..4)),
      sponsors: event.sponsors.sample(rand(1..2))
    )
    moderator = panel.panel_panelists.first
    moderator.update(is_moderator: true)
  end


end 

# TO DO: Panels (in Event + panelPanelists + panelSponsors) / 

puts "=== SEEDING ENDED ==="
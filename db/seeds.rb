require 'faker'

puts "===SEEDING START==="
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
50.times do |i|
  Sponsor.create(name: Faker::Company.name, logo_src: "https://joedietrich.dev/imagestore/logos/logoipsum-logo-#{i + 1}.svg")
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
end 

# TO DO: Panelists
# TO DO: EventSponsors (in Events) / Honorees (in Event) / Hosts (in Event)
# TO DO: Panels (in Event + panelPanelists + panelSponsors) / 

puts "===SEEDING ENDED==="
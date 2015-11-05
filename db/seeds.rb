Flight.destroy_all
Airline.destroy_all

airports = %w(PHL JFK LAX SFO MIA ATL LHR)

airlines = { aa: 'American Airlines',
             as: 'Alaska Airlines',
             ba: 'British Airways',
             dl: 'Delta Airlines',
             ac: 'Air Canada',
             vs: 'Virgin Atlantic' }


airlines.each do |abbrev, full_name|
  Airline.create abbreviation: abbrev, name: full_name
end

starting_date = 1.day.ago.midnight

7.times do
  20.times do
    flight = Flight.new airline: Airline.sample,
                        number: rand(101..999),
                        origin: airports.sample,
                        scheduled_at: (starting_date + (rand(17..23).hours)),
                        gate: "#{['B', 'C', 'D', 'E'].sample}#{rand(1..19)}"

    flight.estimated_at = flight.scheduled_at

    delayed = (rand(100) < 33)
    flight.estimated_at += (rand(1..60).minutes) if delayed

    flight.save
  end

  starting_date += 1.day
end

puts "#{Airline.count} airlines."
puts "#{Flight.count} flights."

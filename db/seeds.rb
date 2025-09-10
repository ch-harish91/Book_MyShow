# db/seeds.rb

# --- Movies ---
movie1 = Movie.find_or_create_by!(title: "Avengers") do |m|
  m.description = "Superhero action film"
  m.language = "English"
  m.genre = "Action"
  m.duration = 180
end

movie2 = Movie.find_or_create_by!(title: "Inception") do |m|
  m.description = "Sci-fi thriller"
  m.language = "English"
  m.genre = "Sci-fi"
  m.duration = 148
end

# --- Theatres ---
theatre1 = Theatre.find_or_create_by!(name: "PVR Cinemas") do |t|
  t.location = "Hyderabad"
  t.total_seats = 150
end

theatre2 = Theatre.find_or_create_by!(name: "INOX") do |t|
  t.location = "Bangalore"
  t.total_seats = 200
end

# --- Shows ---
show1 = Show.find_or_create_by!(movie: movie1, theatre: theatre1, start_time: "2025-09-02 10:00") do |s|
  s.end_time = "2025-09-02 13:00"
  s.ticket_price = 250
end

show2 = Show.find_or_create_by!(movie: movie2, theatre: theatre2, start_time: "2025-09-02 14:00") do |s|
  s.end_time = "2025-09-02 16:30"
  s.ticket_price = 300
end

# --- Users ---
user1 = User.find_or_create_by!(email: "harish@example.com") do |u|
  u.name = "Harish"
  u.phone_number = "9876543210"
  u.password = "password"
end

user2 = User.find_or_create_by!(email: "hadithyh@example.com") do |u|
  u.name = "Hadithyh"
  u.phone_number = "98090543210"
  u.password = "abcdef"
end

# --- Seats for Shows ---
[ show1, show2 ].each do |show|
  ("A".."B").each do |row|       # Rows A and B
    (1..10).each do |num|        # Seats 1 to 10
      Seat.find_or_create_by!(show: show, seat_number: "#{row}#{num}") do |seat|
        seat.status = "available"
      end
    end
  end
end

# --- Bookings (linking seats properly) ---
# Book 2 seats in show1 for Harish
seat_a1 = Seat.find_by(show: show1, seat_number: "A1")
seat_a2 = Seat.find_by(show: show1, seat_number: "A2")

[ seat_a1, seat_a2 ].each do |seat|
  Booking.find_or_create_by!(user: user1, show: show1, seat: seat) do |b|
    b.total_price = show1.ticket_price
  end
  seat.update!(status: "booked")
end

# Book 3 seats in show2 for Hadithyh
[ "B1", "B2", "B3" ].each do |sn|
  seat = Seat.find_by(show: show2, seat_number: sn)
  Booking.find_or_create_by!(user: user2, show: show2, seat: seat) do |b|
    b.total_price = show2.ticket_price
  end
  seat.update!(status: "booked")
end

puts "Seeding completed successfully!"

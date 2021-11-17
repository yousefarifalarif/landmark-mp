# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
User.destroy_all

things = ["to dance", "to sing", "to party", "to play", "to have fun", "to sleep",
          "to climb", "to hike", "to decorate", "for your wedding", "for your birthday party"]
adj = ["great", "lovely", "perfect", "amazing", "cool"]

# Create 4 users
max = User.new(
  first_name: "Max",
  last_name: "Kern",
  email: "m.kern@ingwiest.de",
  password: "123456",
  phone_number: "004915164301315"
)
file = URI.open('https://ca.slack-edge.com/T02NE0241-U02GGCGKPC2-3c7f620da29e-512')
max.photo.attach(io: file, filename: 'max_kern.png', content_type: 'image/png')
max.save!

yousef = User.new(
  first_name: "Yousef",
  last_name: "Arif",
  email: "yousef@gmail.com",
  password: "123456",
  phone_number: "+971526631622"
)
file = URI.open('https://ca.slack-edge.com/T02NE0241-U02GSM7UGAV-9448e7c7069f-512')
yousef.photo.attach(io: file, filename: 'yousef_arif.png', content_type: 'image/png')
yousef.save!

ethan = User.new(
  first_name: "Ethan",
  last_name: "Hardwick",
  email: "hardwick.ethan@outlook.com",
  password: "123456",
  phone_number: "07535630776"
)
file = URI.open('https://ca.slack-edge.com/T02NE0241-U02GGJZAFQT-8f3107535da3-512')
ethan.photo.attach(io: file, filename: 'ethan_hardwick.png', content_type: 'image/png')
ethan.save!

katie = User.new(
  first_name: "Katie",
  last_name: "Lin",
  email: "katiekklht@gmail.com",
  password: "123456",
  phone_number: "+85296055534"
)
file = URI.open('https://ca.slack-edge.com/T02NE0241-U02GJLFE82G-310f7aa18642-512')
katie.photo.attach(io: file, filename: 'katie_lin.png', content_type: 'image/png')
katie.save!

# Create Berlin landmarks
landmarks = [
  { name: "Brandenburg Gate", url: "https://media.cntraveler.com/photos/5b914e80d5806340ca438db1/16:9/w_2560,c_limit/BrandenburgGate_2018_GettyImages-549093677.jpg" },
  { name: "Reichstag Building", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Berlin_reichstag_west_panorama_2.jpg/1920px-Berlin_reichstag_west_panorama_2.jpg" },
  { name: "Berlin Television Tower", url: "https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcRCrPmHB2XnuV0bO-aWf9r91WKF1MY-sb7b2TCsSBcGbWdnRe1NWxfiggmDk2jt2RtF9-D23JDUuPUMfyLrnhSJyg" },
  { name: "East Side Gallery", url: "http://images6.fanpop.com/image/photos/41500000/east-side-gallery-berlin-4-cutiepie1112-41587474-1600-1066.jpg" },
  { name: "Berlin Cathedral", url: "https://img.locationscout.net/images/2017-09/berlin-cathedral-germany_l.jpeg" }
]
landmarks.each do |item|
  landmark = Landmark.new(
    name: item[:name],
    location: "Berlin",
    description: "A #{adj.sample} place #{things.sample}, #{things.sample} and #{things.sample}",
    price_per_day: rand(49.99...999.99) + 0.99,
    user: yousef
  )
  file = URI.open(item[:url])
  landmark.photo.attach(io: file, filename: "#{item[:name]}.png", content_type: 'image/png')
  landmark.save!
end

# Create Dubai landmarks
landmarks = [
  { name: "Burj Al Arab", url: "https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-9/186122816_3782918555150135_1907704415300450352_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=e3f864&_nc_ohc=cSYlIyxPIyUAX_5MD9S&_nc_ht=scontent-hkg4-1.xx&oh=edace1579f32f94c410bfdbe93c710ad&oe=61BC5DAE" },
  { name: "Burj Khalifa", url: "https://adventuresofagoodman.com/wp-content/uploads/2017/05/Burj-Khalifa-Fountain-Show-Dubai-Mall-UAE-Greg_Goodman-AdventuresofaGoodMan-11-Edit.jpg" },
  { name: "The Dubai Fountain", url: "https://res.cloudinary.com/dcm/image/upload/f_auto/v1/prod/t/thumbnailfountain.png" },
  { name: "The Dubai Frame", url: "https://www.timeoutdubai.com/cloud/timeoutdubai/2021/09/11/SZpCE2xs-The-Dubai-Frame-1200x900.jpg" },
  { name: "The Dubai Mall", url: "https://www.timeoutdubai.com/cloud/timeoutdubai/2021/09/12/ewNI4DDL-Dubai-Mall-4-1200x900.jpg" }
]
landmarks.each do |item|
  landmark = Landmark.new(
    name: item[:name],
    location: "Dubai",
    description: "A #{adj.sample} place #{things.sample}, #{things.sample} and #{things.sample}",
    price_per_day: rand(49.99...999.99)+ 0.99,
    user: max
  )
  file = URI.open(item[:url])
  landmark.photo.attach(io: file, filename: "#{item[:name]}.png", content_type: 'image/png')
  landmark.save!
end

# Create London landmarks
landmarks = [
  { name: "Tower of London", url: "https://cdn.cheapoguides.com/wp-content/uploads/sites/4/2020/04/iStock-1141292537.jpg" },
  { name: "Buckingham Palace", url: "https://img.theculturetrip.com/1440x807/smart/wp-content/uploads/2018/11/emdcer.jpg" },
  { name: "10 Downing Street", url: "https://upload.wikimedia.org/wikipedia/commons/7/78/Union_and_French_flag_at_half-mast_in_10_Downing_Street.jpg" },
  { name: "London Eye", url: "https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_3000,h_2000,f_auto/w_80,x_15,y_15,g_south_west,l_klook_water/activities/ikknf4oeysojhyv2z0jk/LondonEyeTickets-KlookHongKong.jpg" },
  { name: "Tower Bridge", url: "https://cdn.getyourguide.com/img/location/5b8e2640b4d58.jpeg/88.jpg" }
]
landmarks.each do |item|
  landmark = Landmark.new(
    name: item[:name],
    location: "London",
    description: "A #{adj.sample} place #{things.sample}, #{things.sample} and #{things.sample}",
    price_per_day: rand(49.99...999.99) + 0.99,
    user: ethan
  )
  file = URI.open(item[:url])
  landmark.photo.attach(io: file, filename: "#{item[:name]}.png", content_type: 'image/png')
  landmark.save!
end

# Create Hong Kong landmarks
landmarks = [
  { name: "Victoria Peak", url: "https://www.thepeak.com.hk/sites/peak/files/inline-images/The%20Peak%20Tower_8.jpg" },
  { name: "Tsing Ma Bridge", url: "https://images.on-this.website/27763_1905862703582c949a626b1.jpg" },
  { name: "Temple Street Night Market", url: "https://www.discoverhongkong.com/content/dam/dhk/intl/explore/neighbourhoods/yau-tsim-mong/intro/yau_tsim_mong_16_9_4.jpg" },
  { name: "Avenue of stars", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Avenue_of_Stars_Hong_Kong_Bruce_Lee_Statue.jpg/2560px-Avenue_of_Stars_Hong_Kong_Bruce_Lee_Statue.jpg" },
  { name: "Sky 100", url: "https://media.timeout.com/images/105244790/image.jpg" }
]
landmarks.each do |item|
  landmark = Landmark.new(
    name: item[:name],
    location: "Hong Kong",
    description: "A #{adj.sample} place #{things.sample}, #{things.sample} and #{things.sample}",
    price_per_day: rand(49.99...999.99) + 0.99,
    user: katie
  )
  file = URI.open(item[:url])
  landmark.photo.attach(io: file, filename: "#{item[:name]}.png", content_type: 'image/png')
  landmark.save!
end

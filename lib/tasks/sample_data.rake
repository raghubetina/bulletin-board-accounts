desc "Fill the database tables with some sample data"
task({ sample_data: :environment }) do
  puts "Sample data task running"

  Board.delete_all
  Listing.delete_all

  if Rails.env.production?
    ActiveRecord::Base.connection.tables.each do |t|
      begin
        ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{t}_id_seq RESTART WITH 1")
      rescue ActiveRecord::StatementInvalid
        # Skip tables that don't have an id sequence
      end
    end
  end

  # Campus building/dorm names
  campus_locations = [
    "Harper Center",
    "Reynolds Hall",
    "Bartlett Dining Commons",
    "Max Palevsky Residential Commons",
    "Stuart Hall",
    "Cobb Hall",
    "Regenstein Library",
    "Ratner Athletics Center",
    "University Bookstore",
    "Ida Noyes Hall"
  ]

  # Sample post data for different types of campus postings
  post_templates = [
    # Roommate/Housing
    {
      titles: [
        "Looking for roommate - Spring Quarter",
        "Sublet available - Summer 2024",
        "Room available in 3BR apartment",
        "Seeking quiet roommate for double",
        "Off-campus housing near campus",
        "1BR in Hyde Park - Great Deal",
        "Summer Housing Swap Available"
      ],
      bodies: [
        "Clean, quiet grad student looking for roommate to share 2BR apartment. $800/month + utilities. Walking distance to campus. No pets, non-smoker preferred. Email me at jchen2024@example.com if interested.",
        "Subletting my room June-August. Furnished, includes utilities and WiFi. Great location on 55th Street. $750/month. Call me: 312-555-0142 for viewing.",
        "Female roommate needed for spring quarter. Shared kitchen and bathroom. Laundry in building. $650/month. WhatsApp - 773-555-0167.",
        "Looking for someone to take over my lease starting next month. Studio apartment, all utilities included. Text 847-555-0189 - urgent!",
        "Room available in house with 3 other students. Large kitchen, backyard, close to shuttle stop. $700/month plus share of utilities. Contact Sarah at sarah.housing@example.com.",
        "Spacious 1BR available immediately. Hardwood floors, updated kitchen, pet-friendly. $950/month. Email rentals@example.com or call 773-555-0125.",
        "Want to swap my downtown studio for Hyde Park housing during summer session. Interested? Contact me at housingswap@example.com."
      ]
    },
    # Tutoring/Academic
    {
      titles: [
        "Math 151 Tutoring Available",
        "MCAT Prep Study Group Forming",
        "Writing Center Peer Tutor Hours",
        "Free Statistics Help Sessions",
        "Language Exchange: Spanish/English",
        "Organic Chemistry Study Buddy Needed",
        "GRE Prep Materials & Coaching"
      ],
      bodies: [
        "PhD student offering calculus tutoring. $40/hour, group rates available. Helped 20+ students improve grades. Email mathtutor@example.com with availability.",
        "Starting MCAT study group for June test date. Meeting twice weekly in Reg Library. All sections covered. Join our WhatsApp group: 312-555-0178.",
        "Peer writing tutor available MWF 2-4pm in Harper Café. Drop in for help with essays, research papers, and citations. Instagram @writinghelp_uc for tips!",
        "Stats TA holding extra office hours before midterm. Room 107 in Stuart. Email statshelp@example.com with questions!",
        "Native Spanish speaker seeking English conversation practice. Will exchange for Spanish lessons. Meet weekly over coffee. Contact maria.language@example.com.",
        "Looking for someone to study O-chem with. Weekly sessions, problem sets, exam prep. Text 773-555-0156 if interested.",
        "Selling GRE prep books + offering coaching sessions. Scored 170Q/168V. $30/hour. Email greprep@example.com."
      ]
    },
    # Items for Sale
    {
      titles: [
        "Textbooks for Sale - Econ Major",
        "Moving Sale - Furniture Must Go!",
        "Bike for Sale - Great Condition",
        "Winter Coat - North Face L",
        "TI-89 Calculator - Like New",
        "Gaming PC - Custom Built",
        "Kitchen Appliances Bundle"
      ],
      bodies: [
        "Selling all my econ textbooks. Mankiw Macro ($50), Varian Micro ($40), Econometrics ($60). Some highlighting but good condition. Text 312-555-0134.",
        "Graduating senior selling: desk ($30), bookshelf ($25), chair ($20), mini fridge ($80). Must pick up by Friday! Email movingsale@example.com.",
        "Trek hybrid bike, barely used. New tires, includes lock and lights. $300 OBO. Perfect for campus commuting. Call 773-555-0145.",
        "Selling warm winter coat, only worn one season. Black North Face parka, size L. Paid $400, asking $200. Contact wintergear@example.com.",
        "Graphing calculator required for engineering classes. Works perfectly, includes manual. $80 (retail $150). WhatsApp 847-555-0198.",
        "Custom gaming PC: RTX 3070, Ryzen 5600X, 16GB RAM. Built last year, runs everything. $1200. Serious inquiries: gamingpc@example.com.",
        "Moving out - selling Instant Pot, air fryer, coffee maker as bundle. All like new. $150 for everything. Text 312-555-0111."
      ]
    },
    # Events/Activities
    {
      titles: [
        "Jazz Ensemble Concert Tonight",
        "Intramural Basketball Team Needs Players",
        "Film Screening: Student Documentary",
        "Yoga Class - Beginners Welcome",
        "Board Game Night at Reynolds",
        "Free Piano Concert Saturday",
        "Improv Comedy Show Friday"
      ],
      bodies: [
        "UC Jazz Ensemble performing at 8pm in Mandel Hall. Free admission with student ID. Reception to follow. Instagram @ucjazzensemble for updates.",
        "Co-ed basketball team looking for 2 more players. Games Sunday evenings. All skill levels welcome! Email hoops@example.com to join.",
        "Screening my senior thesis documentary about campus sustainability. Thursday 7pm in Cobb 307. Q&A after. RSVP: filmmaker@example.com.",
        "Free yoga sessions every Tuesday 6pm at Ratner. Mats provided. Great stress relief during finals! Text 773-555-0123 to reserve spot.",
        "Weekly board game meetup, Fridays 8pm in Reynolds lounge. Bring snacks to share! Join our Discord: boardgames@example.com.",
        "Free piano concert Saturday night at Reynolds Hall, 7-9pm. Classical and jazz selections. For more details, Instagram @pianoconcertuc.",
        "Off-Off Campus improv show Friday 10pm. $5 suggested donation. Limited seats! Reserve at comedy@example.com."
      ],
      event_times: [ nil, nil, nil, nil, nil, "Saturday 9pm", "Friday 11:30pm" ]
    },
    # Jobs/Opportunities
    {
      titles: [
        "Research Assistant Needed",
        "Barista Position - Campus Café",
        "Paid Psychology Study Participants",
        "Dog Walker Wanted - Flexible Hours",
        "Summer Internship Opportunity",
        "Campus Tour Guide Positions",
        "Freelance Web Developer Needed"
      ],
      bodies: [
        "Economics professor seeking RA for data analysis project. 10 hrs/week, $15/hour. Experience with Stata preferred. Apply: professor@example.com.",
        "Harper Café hiring part-time barista. Morning shifts available. Training provided. Call manager at 312-555-0190.",
        "Psych department recruiting for memory study. 2-hour session, $30 compensation. Must be 18-25 years old. Sign up: psychstudy@example.com.",
        "Need reliable dog walker for my two labs. 3x per week, afternoons. $20/walk. Must love dogs! Text 773-555-0177.",
        "Local nonprofit seeking summer marketing intern. Great experience for business/communications majors. Email internship@example.com.",
        "Admissions office hiring student tour guides. $12/hour, flexible schedule. Great public speaking experience. Apply: tours@example.com.",
        "Small business needs website updates. WordPress experience required. $25/hour. Portfolio to: webdev@example.com."
      ]
    },
    # Lost & Found
    {
      titles: [
        "Lost: Blue North Face Backpack",
        "Found: Set of Keys near Quad",
        "Missing Cat - Please Help!",
        "Found: iPhone in Library",
        "Lost: Gold Necklace - Sentimental Value",
        "Found: Airpods in Bartlett",
        "Lost: Prescription Glasses"
      ],
      bodies: [
        "Left my backpack in Swift Hall yesterday. Contains laptop and notebooks. If found, please email lostbackpack@example.com - reward offered!",
        "Found keys on keychain with Cubs logo near main quad. Email foundkeys@example.com to claim.",
        "Orange tabby cat missing since Tuesday. Answers to 'Schrodinger'. Indoor cat, very friendly. Last seen near 57th Street. Call 847-555-0159 if spotted!",
        "Found iPhone 12 in Reg A-level. Currently at circulation desk.",
        "Lost gold chain necklace, possibly in Bartlett or gym. Gift from grandmother. Reward if found! Contact: lostnecklace@example.com.",
        "Found Airpods case in Bartlett dining hall Monday evening. Text 312-555-0102 with case color to claim.",
        "Lost my prescription glasses (black frames) somewhere between Cobb and Harper. Really need them! Email glasses@example.com."
      ]
    },
    # Free Stuff
    {
      titles: [
        "Free Couch - Must Go Today!",
        "Giving Away Old Textbooks",
        "Free Food from Event",
        "Moving - Free Boxes Available",
        "Free Plant Cuttings"
      ],
      bodies: [
        "Moving out, giving away grey IKEA couch. Some wear but comfortable. First come first served. Pickup only. Text 773-555-0188.",
        "Cleaning out bookshelf. Various textbooks and novels free to good home. Box outside my door in Max P, room 412.",
        "Leftover catering from department event. Sandwiches, salads, cookies in Harper 140. Come quick!",
        "Just moved - have 20+ cardboard boxes in various sizes. Free! Behind Bartlett loading dock.",
        "Propagated too many plants! Free pothos and snake plant cuttings. Email plantlover@example.com for pickup."
      ]
    },
    # Rideshare/Transportation
    {
      titles: [
        "Ride to O'Hare Friday Morning",
        "Looking for Carpool to Milwaukee",
        "Driving to NYC for Break",
        "Daily Commute Share to Loop",
        "Moving Help Needed - Will Pay"
      ],
      bodies: [
        "Need ride to O'Hare Friday 8am. Will split gas and tolls. Contact: airport@example.com.",
        "Anyone driving to Milwaukee this weekend? Can contribute gas money. WhatsApp 312-555-0144.",
        "Driving to NYC next Wednesday, room for 2 passengers. $50 each. Email roadtrip@example.com for details.",
        "Looking to share daily commute to Loop. Leave campus 8:30am, return 6pm. Text 773-555-0166.",
        "Need help moving some furniture Saturday morning. 2 hours max. Will pay $20/hour. Call 847-555-0133."
      ]
    }
  ]

  # Track used titles per board to avoid duplicates
  used_titles_per_board = {}

  campus_locations.sample(5).each do |location|
    board = Board.new
    board.name = location
    board.save

    # Initialize tracking for this board
    used_titles_per_board[board.id] = Set.new

    # Create a shuffled list of all available posts
    available_posts = []
    post_templates.each do |template|
      template[:titles].each_with_index do |title, index|
        available_posts << { template: template, title_index: index }
      end
    end
    available_posts.shuffle!

    # Select a random number of posts, ensuring no duplicates
    num_posts = rand(3..10)
    selected_posts = available_posts.first(num_posts)

    selected_posts.each do |post_data|
      template = post_data[:template]
      title_index = post_data[:title_index]

      listing = Listing.new
      listing.board_id = board.id
      listing.title = template[:titles][title_index]
      listing.body = template[:bodies][title_index]

      # More realistic date ranges for campus postings
      listing.created_at = Faker::Date.backward(days: 30)

      # Different expiration patterns based on post type
      if template[:titles][title_index].include?("Lost") || template[:titles][title_index].include?("Found")
        listing.expires_on = Faker::Date.between(from: listing.created_at + 7.days, to: listing.created_at + 14.days)
      elsif template[:titles][title_index].include?("Sale") || template[:titles][title_index].include?("Moving")
        listing.expires_on = Faker::Date.between(from: listing.created_at + 3.days, to: listing.created_at + 10.days)
      elsif template[:event_times] && template[:event_times][title_index]
        # For events with specific times (concerts, shows), expire right after the event
        if template[:event_times][title_index].include?("Saturday")
          # Set expiration to next Saturday after creation + specified time
          next_saturday = listing.created_at.next_occurring(:saturday)
          listing.expires_on = next_saturday
        elsif template[:event_times][title_index].include?("Friday")
          # Set expiration to next Friday after creation + specified time
          next_friday = listing.created_at.next_occurring(:friday)
          listing.expires_on = next_friday
        end
      elsif template[:titles][title_index].include?("Free") && template[:bodies][title_index].include?("quick")
        # Free food expires quickly
        listing.expires_on = listing.created_at + 1.day
      else
        listing.expires_on = Faker::Date.between(from: listing.created_at + 14.days, to: listing.created_at + 45.days)
      end

      listing.save
    end
  end

  puts "There are now #{Board.count} rows in the boards table."
  puts "There are now #{Listing.count} rows in the listings table."
end

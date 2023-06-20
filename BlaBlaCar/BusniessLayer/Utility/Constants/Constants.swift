//
//  Constants.swift
//  BlaBlaCar
//
//  Created by Pragath on 10/05/23.
//

import Foundation


struct Constants {
    
    struct ErrorBox {
        static var error = "Error"
        static var okay = "Okay"
        static var retry = "Retry"
        static var done = "Done"
        static var userExists = "User already exists \n Please Sign In to Continue"
        static var noUserExists = "No such user exists \n Register to continue"
    }
    
    struct Images {
        static var eyeClose      = "eye.slash"
        static var eye           = "eye"
        static var background    = "background2"
        static var mail          = "email_logo"
        static var infoImage     = "info.circle"
        static var backArrow     = "chevron.backward"
        static var minusCircle   = "minus.circle"
        static var plusCircle    = "plus.circle"
        static var person        = "person"
        static var personFill    = "person.circle.fill"
        static var starFilled    = "star.fill"
        static var downArrow     = "chevron.down"
        static var rightArrow    = "chevron.right"
        static var walkingFig    = "figure.walk"
        static var facemask      = "facemask"
        static var filledBag     = "bag.fill"
        static var bigRightArrow = "arrow.right"
        static var calendar      = "calendar"
        static var circleInsideCircle = "circle.circle"
        static var pencil = "pencil"
        static var cross  = "multiply"
        static var checkmarkSeal = "checkmark.seal"
        static var seat = "figure.seated.seatbelt"
        static var checkmarkFilled = "checkmark.circle.fill"
        static var clock = "clock"
        static var car = "car"
        static var location = "mappin.circle.fill"
        static var magnifyingGlass = "magnifyingglass"
        static var locationPointer = "location.north.circle.fill"
    }
    
    struct Headings {
        static var emailPassHeading = "What's your email and password?"
        static var fullNameHeading = "What's your name?"
        static var dobHeading = "What's your date of birth?"
        static var genderHeading = "What's your gender?"
        static var signUpPagesHeading = "Finish signing up"
        static var onBoardingPage = "Your pick of rides at low prices"
        static var signUpHeading = "How do you want to Sign up?"
        static var loginHeading = "How do you want to Log in?"
        static var isMember = "Already a member?"
        static var notMember = "Not a Member?"
        static var backAlertHeading = "Are You Sure?\nIf you go back your progress will be lost."
        static var deleteVehicleHeading = "Are you Sure? \n You want to delete the vehicle"
        static var backAlertSubHeading = "Data will not be saved"
        static var recentSearches = "Recent searches"
        static var selectSeats = "Selected seats"
        static var tripInfo = "Trip Info"
        static var paymentMethod = "Payment method"
        static var departureDate = "Date of departure"
        static var departureDateAndTime = "Date and time of departure"
        static var selectDate = "Select a date"
        static var rideDetails = "Ride Details"
        static var ridePlan = "Ride Plan"
        static var editYourPublication = "Edit your publication"
        static var itineraryDetails = "Itinerary details"
        static var editPrice = "Edit price per seat"
        static var editSeats = "Seating options"
        static var availableSeats = "Available seats"
        static var selectVehicle = "Select a Vehicle"
        static var routeSelection = "Route selection"
        static var carPool = "Car Pool"
        static var myRides = "My rides"
        static var perSeatPrice = "Price per seat"
        static var profile = "Profile"
        static var verifyProfile = "Verify your profile"
        static var aboutYou = "About you"
        static var editProfile = "Edit profile"
        static var aboutMe = "About me"
        static var vehicleInfo = "Vehicle info"
        static var editVehicle = "Edit Vehicle Options"
        static var rideCreated = "Ride Created!!"
        static var rideBooked  = "Ride Booked!!"
        static var numOfSeats = "Number of seats"
        static var selectFromGallery = "Select from gallery"
        static var accountSettings = "Account settings"
        static var vehicles = "Vehicles"
        static var miniBio = "Mini bio:"
        static var vehicleDetails = "Vehicle Details: "
        static var totalDistanceInKm = "Total distance (in km)"
        static var estimatedTime = "Estimated time to reach"
        static var confirmLocation = "Confirm Location"
        static var selectLocation = "Select Location"
        static var searchLocation = "Search Location"
        static var selectedLocation = "Selected Location"
        static var permissionDenied = "Permission Denied"
        static var cancelBooking = "Cancel Booking"
        static var cancelYOurRide = "Cancel your ride"
        static var passengers = "Passengers:"
    }
    
    struct ButtonsTitle{
        static var next = "Next"
        static var back = "Back"
        static var done = "Done"
        static var delete = "Delete"
        static var yes = "Yes"
        static var okay = "Okay"
        static var signUp = "Sign up"
        static var logIn = "Log in"
        static var logOut = "Log out"
        static var continueWithEmail = "Continue with Email"
        static var seeAll = "See all"
        static var close = "close"
        static var confirmSeats = "Confirm seats"
        static var continueBtn  = "Continue"
        static var confirmRide  = "Confirm Ride"
        static var addNewVehicle = "Add new vehicle"
        static var publishRide = "PUBLISH RIDE"
        static var proceed = "Proceed"
        static var search = "SEARCH"
        static var findRide = "Find a Ride"
        static var offerRide = "Offer a Ride"
        static var helpSupport = "Help & support"
        static var addMiniBio = "Add a mini bio"
        static var addVehicle = "Add vehicle"
        static var currentLocation = "Use current location"
        static var settings = "Settings"
        static var cancel = "Cancel"
    }
    
    struct TextfieldPlaceholder {
        static var email = "Email"
        static var password = "Password"
        static var firstName = "First Name"
        static var secondName = "Last Name"
        static var gender = "Gender"
        static var dob = "Date Of Birth"
        
        static var dropLocation = "Enter Drop Location"
        static var pickupLocation = "Enter Pickup Location"
        static var addBio = "Add bio"
        static var country = "Country"
        static var type = "Type"
        static var year = "Year"
        static var color = "Color"
        static var findLocation = "Find locations here"
    }
    
    struct Regex {
        static var selfMatch        = "SELF MATCHES %@"
        static var passRegex        = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&/,`^()-+=_~;:'.])[A-Za-z\\d@$!%*#?&/,`^()-+=_~;:'.]{8,16}$"
        static var emailRegex       = "^[a-zA-Z0-9.!$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$"
        static var numRegex         = ".*[A-Za-z!@#$%^&*()\\-_=+{}|?>.<]+.*"
        static var alphabetRegex    = ".*[0-9!@#$%^&*()\\-_=+{}|?>.<]+.*"
        static var containsChRegex  = ".*[!@#$%^&*()\\-_=+{}|?>.<]+.*"
        static var isLowerRegex     = ".*[a-z]+.*"
        static var isUpperRegex     = ".*[A-Z]+.*"
    }
//    static var emailRegex   = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]+.[A-Za-z]"
//    static let email        = "^[a-zA-Z0-9.!$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$"
//    static var passRegex    = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[A-Za-z0-9!@#$%^&*()-_=+{}[]?|/>.<,:;']{8,16}"
//    static let password     = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&/,`^()-+=_~;:'.])[A-Za-z\\d@$!%*#?&/,`^()-+=_~;:'.]{8,16}$"

    struct ValidationsMsg{
        static var passNotCorrect   = "password is not correct"
        static var digitOnly        = "must be digits only"
        static var lessThan100      = "not greater than 100"
        static var emailNotEmpty    = "email should not be empty"
        static var invalidEmpty     = "invalid Email eg: dummy@gmail.com"
        static var passNotEmpty     = "password should not be empty"
        static var passNotInRange   = "password range must be between 8 to 16"
        static var uppercase        = "must contain at least one uppercase"
        static var lowercase        = "must contain at least one lowercase"
        static var specialCh        = "must contain at least one special character"
        static var bioLimit         = "Bio length exceeds the limit!"
        static var onlyAlphabets    = "must contain only alphabets"
        static var max10Digit       = "number of digits must be 10"
        
    }

    struct UserDefaultKeys {
        
        static let session = "SessionAuthToken"
        static let profileData = "UserProfileData"
    }
    
    // MARK: - empty rides view
    struct EmptyRidesView {
        static let image    = "emptyRideImage"
        static let title    = "Currently their are no rides present."
        static let caption  = "Find the perfect ride from thousands of destinations, or publish to share your travel costs."
    }
    
    struct Description {
        static var paymentType = "Pay via wallet, card or cash"
        static var selectingSeat = "Select a seat"
        static var toCompletePayment = "You will be charged after ride completion"
        static var or = "or"
        static let addAboutRide = "Got anything to add about the ride? Write it here."
        static let forExample = """
        Eg; Flexible about when and where to meet? Got limited space in the boat?Need passengers to be punctual? etc.
        """
        static let type100 = "Type about 100 words here..."
        static var rs2000 = "Rs 2000"
        static var rs0 = "Rs 0"
        static var bioDescription = "Bio must be between 1 - 50 characters in length."
        static var seats = "seats"
        static var color = "Color - "
        static var number = "Number - "
        static var dash = " - "
        static var space = " "
        static var totalPrice = "Total price"
        static var bookedSeats = "Booked seats"
        static var priceOneSeat = "Price for one seat"
        static var distToWalk = "0 km"
        static var seat = "seat"
        static var noRidesFound = "No rides found"
        static var PermissionInSettigs = "Please Enable Permissions in App Settings"
        static var allFieldsMandatory = "All fields are mandatory."
        static var seatBooked = " seat booked"
        static var seatsBooked = " seats booked"
    }
    
    struct StringFormat {
        static var zeroDigit = "%.f"
        static var oneDigit = "%.1f"
        static var twoDigit = "%.2f"
    }
    
    static let passDesc = "In order to protect your account, make sure your password: \n\nLength must be between 8 and 16\n Includes a Uppercase letter \nIncludes a Lowercase letter\nIncludes a Special Character"
    static let pDesc = "Password must be between 8 to 16 in length, contain at least one uppercase, one lowercase, one special character"
    static let fullNameDesc = "Enter the same name as on your government ID\n(Fields should not be empty)"
    static let dobDesc = "Enter the same DOB as on your government ID"
}
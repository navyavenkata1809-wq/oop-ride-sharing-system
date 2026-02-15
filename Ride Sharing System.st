"Ride Sharing System in Smalltalk - Optimized for GNU Smalltalk / JDoodle"

"--------------------------------------------------"
"Ride Class Definition"
"--------------------------------------------------"
Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

!Ride methodsFor: 'initialization'!
initializeWithId: anId pickup: aPickup dropoff: aDropoff distance: aDistance [
    rideID := anId.
    pickupLocation := aPickup.
    dropoffLocation := aDropoff.
    distance := aDistance.
    ^self
]! !

!Ride methodsFor: 'accessing'!
calculateFare [
    "Subclasses will override this"
    ^ 0
]

rideDetails [
    Transcript show: 'Ride ID: ', rideID asString; cr.
    Transcript show: 'From: ', pickupLocation asString, ' To: ', dropoffLocation asString; cr.
    Transcript show: 'Distance: ', distance printString, ' miles'; cr.
    Transcript show: 'Fare: $', self calculateFare printString; cr.
]! !

"--------------------------------------------------"
"StandardRide Subclass"
"--------------------------------------------------"
Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

!StandardRide methodsFor: 'accessing'!
calculateFare [
    ^ 5.0 + (distance * 1.5)
]

rideDetails [
    Transcript show: '[Standard Ride] '; cr.
    super rideDetails.
]! !

"--------------------------------------------------"
"PremiumRide Subclass"
"--------------------------------------------------"
Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

!PremiumRide methodsFor: 'accessing'!
calculateFare [
    ^ 10.0 + (distance * 3.0)
]

rideDetails [
    Transcript show: '[Premium Ride] '; cr.
    super rideDetails.
]! !

"--------------------------------------------------"
"Driver Class Definition"
"--------------------------------------------------"
Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

!Driver methodsFor: 'initialization'!
initializeWithId: anId name: aName rating: aRating [
    driverID := anId.
    name := aName.
    rating := aRating.
    assignedRides := OrderedCollection new.
    ^self
]! !

!Driver methodsFor: 'operations'!
addRide: aRide [
    assignedRides add: aRide.
]

getDriverInfo [
    Transcript show: '--- Driver Info ---'; cr.
    Transcript show: 'Name: ', name asString, ' (Rating: ', rating printString, ')'; cr.
    Transcript show: 'Rides Completed: ', assignedRides size printString; cr; cr.
]! !

"--------------------------------------------------"
"Rider Class Definition"
"--------------------------------------------------"
Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'!

!Rider methodsFor: 'initialization'!
initializeWithId: anId name: aName [
    riderID := anId.
    name := aName.
    requestedRides := OrderedCollection new.
    ^self
]! !

!Rider methodsFor: 'operations'!
requestRide: aRide [
    requestedRides add: aRide.
]

viewRides [
    Transcript show: '--- Ride History for ', name asString, ' ---'; cr.
    requestedRides do: [:each | 
        each rideDetails.
        Transcript show: '--------------------------'; cr.
    ].
]! !

"--------------------------------------------------"
"Main Execution Script"
"--------------------------------------------------"

| ride1 ride2 ride3 myDriver myRider rideList |

"Create rides"
ride1 := StandardRide new initializeWithId: 'S-001' pickup: 'Mall' dropoff: 'Home' distance: 10.
ride2 := PremiumRide new initializeWithId: 'P-999' pickup: 'Office' dropoff: 'Airport' distance: 25.
ride3 := StandardRide new initializeWithId: 'S-002' pickup: 'Gym' dropoff: 'Cafe' distance: 3.

rideList := OrderedCollection new.
rideList add: ride1; add: ride2; add: ride3.

"Create Driver and Rider"
myDriver := Driver new initializeWithId: 'D1' name: 'James' rating: 4.9.
myRider := Rider new initializeWithId: 'R1' name: 'Sarah'.

"Demonstrate Logic"
rideList do: [:r | 
    myRider requestRide: r.
    myDriver addRide: r.
].

"Display Results"
myDriver getDriverInfo.
myRider viewRides.

"Explicitly exit for some online environments"
ObjectMemory quit.

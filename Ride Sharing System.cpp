#include <iostream>
#include <vector>
#include <string>
#include <iomanip>

/**
 * CORE PRINCIPLE: ENCAPSULATION & INHERITANCE
 * Ride is the base class for all types of rides.
 */
class Ride {
protected:
    std::string rideID;
    std::string pickupLocation;
    std::string dropoffLocation;
    double distance;
    double baseFare;

public:
    Ride(std::string id, std::string pickup, std::string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist), baseFare(5.0) {}

    virtual ~Ride() {}

    // POLYMORPHISM: Virtual methods to be overridden by subclasses
    virtual double calculateFare() const = 0; 
    
    virtual void rideDetails() const {
        std::cout << "Ride ID: " << rideID << "\n"
                  << "From: " << pickupLocation << " To: " << dropoffLocation << "\n"
                  << "Distance: " << distance << " miles\n"
                  << "Total Fare: $" << std::fixed << std::setprecision(2) << calculateFare() << std::endl;
    }

    std::string getID() const { return rideID; }
};

/**
 * StandardRide Subclass
 */
class StandardRide : public Ride {
public:
    StandardRide(std::string id, std::string pickup, std::string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    // Overriding fare calculation for Standard type
    double calculateFare() const override {
        return baseFare + (distance * 1.5); // $1.5 per mile
    }

    void rideDetails() const override {
        std::cout << "[STANDARD RIDE] ";
        Ride::rideDetails();
    }
};

/**
 * PremiumRide Subclass
 */
class PremiumRide : public Ride {
public:
    PremiumRide(std::string id, std::string pickup, std::string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    // Overriding fare calculation for Premium type
    double calculateFare() const override {
        return (baseFare * 2) + (distance * 3.0); // Higher base and $3.0 per mile
    }

    void rideDetails() const override {
        std::cout << "[PREMIUM RIDE] ";
        Ride::rideDetails();
    }
};

/**
 * Driver Class demonstrating ENCAPSULATION
 */
class Driver {
private:
    std::string driverID;
    std::string name;
    double rating;
    std::vector<Ride*> assignedRides; // Private data member

public:
    Driver(std::string id, std::string n, double r) : driverID(id), name(n), rating(r) {}

    // Method to access and modify private collection
    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        std::cout << "--- Driver Info ---\n"
                  << "ID: " << driverID << " | Name: " << name << " | Rating: " << rating << "/5.0\n"
                  << "Completed Rides: " << assignedRides.size() << "\n" << std::endl;
    }
};

/**
 * Rider Class
 */
class Rider {
private:
    std::string riderID;
    std::string name;
    std::vector<Ride*> requestedRides;

public:
    Rider(std::string id, std::string n) : riderID(id), name(n) {}

    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        std::cout << "--- Ride History for " << name << " ---\n";
        for (const auto& ride : requestedRides) {
            ride->rideDetails();
            std::cout << "--------------------------\n";
        }
    }
};

int main() {
    // Demonstrate Polymorphism with a collection of base class pointers
    std::vector<Ride*> systemRides;

    // Creating different types of rides
    systemRides.push_back(new StandardRide("S101", "Downtown", "Airport", 15.5));
    systemRides.push_back(new PremiumRide("P202", "Luxury Hotel", "Convention Center", 5.2));
    systemRides.push_back(new StandardRide("S103", "Suburb A", "Suburb B", 8.0));

    // Create Driver and Rider
    Driver driver1("D77", "John Doe", 4.8);
    Rider rider1("R55", "Alice Smith");

    std::cout << "Processing Ride Sharing System Operations...\n\n";

    // Assigning rides and demonstrating interactions
    for (Ride* r : systemRides) {
        rider1.requestRide(r);
        driver1.addRide(r);
    }

    // Display Information
    driver1.getDriverInfo();
    rider1.viewRides();

    // Clean up memory
    for (Ride* r : systemRides) {
        delete r;
    }

    return 0;
}

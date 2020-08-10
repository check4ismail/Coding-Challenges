/*
	A popular masseuse receives a sequence of back-to-back appointment requests and is debating
	which ones to accept. She needs a 15-minute break between appointments and therefore she cannot
	accept any adjacent requests. Given a sequence of back-to-back appointment requests (all multiple
	of 15 minutes, none overlap, and none can be moved), find the optimal (highest total booked minutes)
	set the masseuse cna honor. Return the number of minutes.

	EXAMPLE
	Input: {30, 15, 60, 75, 45, 15, 15, 45}
	Output: { [30, 60, 45, 45] }

	To run this coding challenge locally, enter the following commands via Terminal:
	1. swiftc -o main Masseuse.swift main.swift data-structures/Heap.swift
	2. ./main
	
*/
import Foundation

struct Appointments: Equatable, CustomStringConvertible {
	let totalMinutes: Int
	let appointments: [Appointment]
	
	static func ==(lhs: Appointments, rhs: Appointments) -> Bool {
		return lhs.totalMinutes == rhs.totalMinutes
	}
	public var description: String {
		"\(totalMinutes) - \(appointments)"
	}
}

struct Appointment: CustomStringConvertible {
	let index: Int
	let minutes: Int
	
	public var description: String {
		"\(minutes)"
	}
}

func bestForMasseuse(_ arr: [Int]) -> Appointments {
	// Appointments should not be empty
	guard !arr.isEmpty else {
		return Appointments(totalMinutes: 0, appointments: [])
	}
	
	// Appointments should be greater than 1, otherwise return single appointment
	guard arr.count > 1 else {
		return Appointments(totalMinutes: arr[0], appointments: [Appointment(index: 0, minutes: arr[0])])
	}
	
	var complete = false
	var indexTracker = 0
	let strideBy = 2
	var allAppointments: [[Appointment]] = [] // Keeps track of all appointment combinations
	
	while !complete {
	/*
		1. Stride by 2 starting from indexTracker value of 0 (to prevent back to back appointments)
		then add appointments to allAppointments matrix
		2. Start new iteration from last appointment - attempt to increment index by 1 if possible, then add new combination to matrix
		3. Repeat step 2 until all combinations are exhausted and added to matrix
		4. If 2 or 3 isn't possible, simply start from indexTracker value of 1 and stride by 2 elements to catch all combinations
		5. Apply steps 2 & 3 to step 4 if possible
		
	*/
		var appointments: [Appointment] = []
		for i in stride(from: indexTracker, to: arr.count, by: strideBy) {
			appointments.append(Appointment(index: i, minutes: arr[i]))
		}
		allAppointments.append(appointments)
		
		if let lastAppointment = appointments.last,
			lastAppointment.index + 1 < arr.count {
			for i in stride(from: appointments.count - 1, to: -1, by: -1) {
				let appointment = appointments[i]
				let newIndex = appointment.index + 1
				let newMinutes = arr[newIndex]
				
				appointments[i] = Appointment(index: newIndex, minutes: newMinutes)
				allAppointments.append(appointments)
			}
			complete = true
		} else {
			indexTracker += 1
		}
		if indexTracker > 1 {
			complete = true
		}
	}
	
	// Will keep track of Appointments with greatest number of total minutes
	var heap = Heap<Appointments>(sort: { $0.totalMinutes > $1.totalMinutes })
	print("Original arr - \(arr)")	// Original arr
	print("Rows of matrix")
	allAppointments.forEach { appointments in
		print(appointments)	// Printing each row of matrix to display all combos
		let totalMinutes = appointments.reduce(0, {$0 + $1.minutes })
		heap.insert(Appointments(totalMinutes: totalMinutes, appointments: appointments))
	}
	return heap.peek()!
}

func main() {
	print("Most optimal appointment combo - \(bestForMasseuse([30, 15, 60, 75, 45, 15, 15, 45]))\n")
	print("Most optimal appointment combo - \(bestForMasseuse([20, 40, 50, 60]))\n")
	print("Most optimal appointment combo - \(bestForMasseuse([20, 40, 50]))\n")
	print("Most optimal appointment combo - \(bestForMasseuse([20, 40]))\n")
	print("Most optimal appointment combo - \(bestForMasseuse([30, 45, 60, 75, 45, 15, 85]))\n")
}

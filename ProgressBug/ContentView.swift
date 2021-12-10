//
//  ContentView.swift
//  ProgressBug
//
//  Created by Oliver Drobnik on 10.12.21.
//

import SwiftUI

let units = Int64(1000)


class Model: ObservableObject
{
	@Published var count: Double = 0
	{
		didSet {
			childProgress.completedUnitCount = Int64(round(count))
			
			childFractionCompleted = childProgress.fractionCompleted
			
			correctParentProgress = Int64(round(Double(parentProgress.totalUnitCount) * parentProgress.fractionCompleted))
		}
	}
	
	@Published var correctParentProgress: Int64 = 0

	
	let parentProgress: Progress
	var parentObservation1: NSKeyValueObservation?
	var parentObservation2: NSKeyValueObservation?
	@Published var parentFractionCompleted: Double = 0
	@Published var parentCompletedUnitCount: Int64 = 0

	let childProgress: Progress
	@Published var childFractionCompleted: Double = 0
	
	init()
	{
		parentProgress = Progress(totalUnitCount: units)
		childProgress = Progress(totalUnitCount: units)
		
		parentProgress.addChild(childProgress, withPendingUnitCount: units)
		
		parentObservation1 = parentProgress.observe(\.completedUnitCount) { progress, value in
			self.parentCompletedUnitCount = progress.completedUnitCount
		}
		
		parentObservation2 = parentProgress.observe(\.fractionCompleted) { progress, value in
			self.parentFractionCompleted = progress.fractionCompleted
		}
	}
}


struct ContentView: View
{
	@ObservedObject var model = Model()
	
	let formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .percent
		formatter.minimumIntegerDigits = 1
		formatter.maximumIntegerDigits = 3
		formatter.maximumFractionDigits = 0
		
		return formatter
		
	}()
	
    var body: some View {
		
		Form {
			
			Section ("Issue Description")
			{
				Text("There is a parent progress that has a total unit count of \(units) units. A child progress was added with pending unit count \(units).\n\nWhen the child progress' completed unit count is updated, then the fraction completed of the parent is updated, but the completed unit count is not.")
			}
			
			Section("Steps to Reproduce")
			{
				HStack(alignment: .firstTextBaseline) {
					Text("1.").bold()
					Text("Drag the slider slowly to the right. ")
					+ Text("Notice that only the parent's fraction completed changes.").foregroundColor(.secondary)
				}
				
				HStack(alignment: .firstTextBaseline) {
					Text("2.").bold()
					Text("Continue dragging the slider to the right maximum. ")
					+ Text("Notice that when you come to the right side of the slider the parent's completed count is updated").foregroundColor(.secondary)
				}.fixedSize(horizontal: false, vertical: false)
				
				HStack(alignment: .firstTextBaseline) {
					Text("3.").bold()
					Text("Drag the slider a bit to the left. ")
					+ Text("Again, only the parent's fraction is updated.").foregroundColor(.secondary)
				}.fixedSize(horizontal: false, vertical: false)
				
				HStack(alignment: .firstTextBaseline) {
					Text("4.").bold()
					Text("Drag the slider to the right maximum. ")
					+ Text("The parent's completed unit count is now double what it should be. In fact every time the child completes, 1000 is added to the parent's completed unit count.").foregroundColor(.secondary)
				}.fixedSize(horizontal: false, vertical: false)
			}.lineLimit(10)
			
			
			
			Section("Parent Progress")
			{
				HStack {
					Text("Total Unit Count")
					Spacer()
					
					Text("\(units)")
				}
				
				HStack {
					Text("Fraction Completed")
					Spacer()
					
					Text(formatter.string(from: NSNumber(value: model.parentFractionCompleted))!)
				}
				
				HStack {
					Text("Completed Unit Count")
					Spacer()
					Text("\(model.parentCompletedUnitCount)").foregroundColor(model.correctParentProgress != model.parentCompletedUnitCount ? .red : .primary)
				}
			}
			
			Section("Child Progress")
			{
				HStack {
					Text("Total Unit Count")
					Spacer()
					
					Text("\(units)")
				}
				
				HStack {
					Text("Fraction Completed")
					Spacer()
					
					let string = formatter.string(from: NSNumber(value: model.childFractionCompleted))!
					Text(string)
				}

				
				Slider(value: $model.count, in: 0...Double(units)) {
					Text("Count")
				} minimumValueLabel: {
					Text("0")
				} maximumValueLabel: {
					Text("\(units)")
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

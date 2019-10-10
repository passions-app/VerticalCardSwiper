// MIT License
//
// Copyright (c) 2017 Joni Van Roost
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import VerticalCardSwiper

class ExampleViewController: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {

    @IBOutlet private var cardSwiper: VerticalCardSwiper!

    private var contactsDemoData: [Contact] = [
        Contact(name: "John Doe", age: 33),
        Contact(name: "Chuck Norris", age: 78),
        Contact(name: "Bill Gates", age: 62),
        Contact(name: "Steve Jobs", age: 56),
        Contact(name: "Barack Obama", age: 56),
        Contact(name: "Mila Kunis", age: 34),
        Contact(name: "Pamela Anderson", age: 50),
        Contact(name: "Christina Anguilera", age: 37),
        Contact(name: "Ed Sheeran", age: 23),
        Contact(name: "Jennifer Lopez", age: 45),
        Contact(name: "Nicki Minaj", age: 31),
        Contact(name: "Tim Cook", age: 57),
        Contact(name: "Satya Nadella", age: 50)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        cardSwiper.delegate = self
        cardSwiper.datasource = self
        cardSwiper.isSideSwipingEnabled = false
        cardSwiper.stackedCardsCount = 3
        cardSwiper.visibleNextCardHeight = 20
        cardSwiper.verticalCardSwiperView.isScrollEnabled = false

        // register cardcell for storyboard use
        cardSwiper.register(nib: UINib(nibName: "ExampleCell", bundle: nil), forCellWithReuseIdentifier: "ExampleCell")
    }

    @IBAction func pressRemoveCards(_ sender: UIBarButtonItem) {
        let c1 = Contact(name: "testUser1", age: 12)
        let oldData = contactsDemoData
        var tmpData = oldData
        tmpData.insert(c1, at: 0)
        let newData = tmpData
        cardSwiper.animateItemChanges(oldData: oldData, newData: newData, updateData: { newData in
            self.contactsDemoData = newData
        })
    }

    @IBAction func pressAddCards(_ sender: UIBarButtonItem) {
        let c1 = Contact(name: "testUser1", age: 12)
        let c2 = Contact(name: "testUser2", age: 12)
        let c3 = Contact(name: "testUser3", age: 12)
        let c4 = Contact(name: "testUser4", age: 12)
        let c5 = Contact(name: "testUser5", age: 12)

        let oldData = contactsDemoData
        var tmpData = oldData
        tmpData.append(c1)
        tmpData.append(c2)
        tmpData.append(c3)
        tmpData.append(c4)
        tmpData.append(c5)
        let newData = tmpData
        cardSwiper.animateItemChanges(oldData: oldData, newData: newData, updateData: { newData in
            self.contactsDemoData = newData
        })
    }

    @IBAction func pressScrollUp(_ sender: UIBarButtonItem) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.scrollToCard(at: currentIndex - 1, animated: true)
        }
    }

    @IBAction func pressScrollDown(_ sender: UIBarButtonItem) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.scrollToCard(at: currentIndex + 1, animated: true)
        }
    }

    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {

        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: index) as? ExampleCardCell {

            let contact = contactsDemoData[index]
            cardCell.setRandomBackgroundColor()
            cardCell.nameLbl.text = "Name: " + contact.name
            cardCell.ageLbl.text = "Age: \(contact.age ?? 0)"
            return cardCell
        }
        return CardCell()
    }

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return contactsDemoData.count
    }

    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        contactsDemoData.remove(at: index)
    }

    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called when a card has animated off screen entirely.
    }

    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
        if let index = cardSwiper.focussedCardIndex {
            let oldData = contactsDemoData
            var tmpData = oldData
            tmpData.remove(at: index)
            let newData = tmpData
            cardSwiper.animateItemChanges(oldData: oldData, newData: newData, updateData: { newData in
                self.contactsDemoData = newData
            })
        }
    }
}

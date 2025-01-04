import UIKit

struct OnboardingsData: Decodable {
    var onboardingsData: [OnboardingData]
}

struct OnboardingData: Decodable {
    let text, image: String
}

class OnboardingController: UIViewController {
    
    var pagesData = [OnboardingData]()
    var pageIndex: Int = -1

    let pageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let pageViews: [Page] = {
        let view = [Page(), Page()]
        view[0].translatesAutoresizingMaskIntoConstraints = false
        view[1].translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

        pageTransition(animated: false, direction: "fromRight")
    }
    
    
    func setupViews() {
        pageContainer.addSubview(pageViews[0])
        pageContainer.addSubview(pageViews[1])

        view.addSubview(pageContainer)
    }
        
    func setupConstraints() {
        pageContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        pageContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        pageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        pageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true

        pageViews[0].topAnchor.constraint(equalTo: pageContainer.topAnchor).isActive = true
        pageViews[0].bottomAnchor.constraint(equalTo: pageContainer.bottomAnchor).isActive = true
        pageViews[0].leadingAnchor.constraint(equalTo: pageContainer.leadingAnchor).isActive = true
        pageViews[0].trailingAnchor.constraint(equalTo: pageContainer.trailingAnchor).isActive = true
        
        pageViews[1].topAnchor.constraint(equalTo: pageContainer.topAnchor).isActive = true
        pageViews[1].bottomAnchor.constraint(equalTo: pageContainer.bottomAnchor).isActive = true
        pageViews[1].leadingAnchor.constraint(equalTo: pageContainer.leadingAnchor).isActive = true
        pageViews[1].trailingAnchor.constraint(equalTo: pageContainer.trailingAnchor).isActive = true
    }
        
    func loadData(fileName: Any) -> OnboardingsData {
        var url = NSURL()
        url = Bundle.main.url(forResource: "onboardingData", withExtension: "json")! as NSURL
        let data = try! Data(contentsOf: url as URL)
        let person = try! JSONDecoder().decode(OnboardingsData.self, from: data)
        return person
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if(touch.view == pageViews[0] || touch.view == pageViews[1]) {
                let location = touch.location(in: view.self)
                if view.safeAreaInsets.left > 30 {
                    if (location.x > self.view.frame.size.width - (view.safeAreaInsets.left * 1.5)) {
                        pageTransition(animated: true, direction: "fromRight")
                    } else if (location.x < (view.safeAreaInsets.left * 1.5)) {
                        pageTransition(animated: true, direction: "fromLeft")
                    }
                } else {
                    if (location.x > self.view.frame.size.width - 40) {
                        pageTransition(animated: true, direction: "fromRight")
                    } else if (location.x < 40) {
                        pageTransition(animated: true, direction: "fromLeft")
                    }
                }
            }
        }
    }
    
    func pageTransition(animated: Bool, direction: String) {

        let result = loadData(fileName: pagesData)
        
        switch direction {
        case "fromRight":
            pageIndex += 1
        case "fromLeft":
            pageIndex -= 1
        default: break
        }
        
        if pageIndex <= -1 {
            
            pageIndex = 0
            
        } else if pageIndex >= result.onboardingsData.count {
            
            pageIndex = result.onboardingsData.count - 1
            dismiss(animated: false, completion: nil)
            
        } else {

            let fromView = pageViews[0].isHidden ? pageViews[1] : pageViews[0]
            let toView = pageViews[0].isHidden ? pageViews[0] : pageViews[1]
            toView.configureOnboarding(theData: result.onboardingsData[pageIndex])

            if animated {
                
                toView.isHidden = false
                let animation = CATransition()
                animation.duration = 0
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.isRemovedOnCompletion = true
                animation.subtype = direction

                let tapAnimationType = "fade"
                switch tapAnimationType {
                case "pageCurl": animation.type = "pageCurl"
                case "fade": animation.type = "fade"
                case "moveIn": animation.type = "moveIn"
                case "push": animation.type = "push"
                case "reveal": animation.type = "reveal"
                default: animation.type = "fade" }

                self.pageContainer.layer.add(animation, forKey: "pageAnimation")
                self.pageContainer.bringSubview(toFront: toView)

                fromView.isHidden = true
                
            } else {
                fromView.isHidden = true
                toView.isHidden = false
            }
        }
    }
    
}

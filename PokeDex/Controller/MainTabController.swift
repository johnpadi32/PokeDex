//
//  MainTabController.swift
//  PokeDex
//
//  Created by John Padilla on 3/15/22.
//

import UIKit

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTabBar()
    }
    
    //MARK: - Helpers
    
    func navigationTabBar() {
        self.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let vc1 = templateNavController(Image: "doc.text.magnifyingglass", title: "Explore", rootViewController: PokedexController(collectionViewLayout: layout))
        let vc2 = templateNavController(Image: "circle.circle.fill", title: "Catch Them", rootViewController: SliderController())
        let vc3 = templateNavController(Image: "square.and.arrow.down", title: "Saved", rootViewController: SavedController())
        
        viewControllers = [vc1, vc2, vc3]
        tabBar.tintColor = .mainRed()
    }
    
    func templateNavController(Image: String, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = UIImage(systemName: Image)
        nav.tabBarItem.title = title
        return nav
    }
}

extension MainTabController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 1 {
            let controller = SliderController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
            
            return false
        }
        return true
    }
}

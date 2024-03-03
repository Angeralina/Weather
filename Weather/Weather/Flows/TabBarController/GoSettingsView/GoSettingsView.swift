//
//  GoSettingsView.swift
//  Weather
//
//  Created by Алина on 02.03.2024.
//
import UIKit


class GoSettingsView: UIView {
    
    // MARK: - IBOutlets
        
    @IBOutlet weak var alertBodyView: UIView!
   

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        // swiftlint:disable force_cast
        let view = UINib(nibName: "GoSettingsView", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configure()
    }
    
    // MARK: - Private methodth
    
    private func configure() {
        alertBodyView.roundCorners(radius: 15.0)
        isHidden = true
    }

    // MARK: - IBActions

    
    @IBAction func open(_ sender: Any) {
        guard let url = URL(string: UIApplication.openSettingsURLString)
            else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}

//
//  ViewController.swift
//  Swift-NewsApp
//
//  Created by Mac on 06/03/21.
//

import UIKit
import SwifterSwift
import SafariServices
import RxCocoa
import RxSwift

protocol FeedViewControllerProtocol: AnyObject {
    var onBack: (() -> Void)? { get set }
    var onSignOut: (() -> Void)? { get set }
    var onSignIn: (() -> Void)? { get set }
//    var onFeedSelected: ((BookDetailVM) -> Void)? { get set }
}

class FeedViewController: BaseViewController,
                          BaseViewControllerProtocol,
                          FeedViewControllerProtocol,
                          FeedStoryboardLodable {
    
    @IBOutlet weak var collectionViewHighlights: UICollectionView!
    @IBOutlet weak var tableViewNews: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!

    private let refreshControl = UIRefreshControl()

    var viewModel: FeedViewModel!
    let first = 1
    var timer = Timer()
    var counter = 0
    		
    var onBack: (() -> Void)?
    var onSignOut: (() -> Void)?
    var onSignIn: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
        bindUI()
    }

    func bindViewModel() {
        viewModel = FeedViewModel()
    }
    
    func setupUI() {
        registerNibs()
        configCollectionView()
    }
        
    func bindUI() {
        observeErrors()
        observeLoading()
        bindCollectionView()
        bindTableView()
        fetchData()
    }
    
    private func observeLoading() {
        viewModel.loading
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe({ event in
                if (event.element == true) {
                    LoadingView.show()
                } else {
                    LoadingView.hide()
                }
            }).disposed(by: bag)
    }
    
    private func registerNibs() {
        tableViewNews.register(UINib.init(nibName: "NewsCell", bundle: nil),
                                      forCellReuseIdentifier: "NewsCell")
        
        collectionViewHighlights.register(
            UINib.init(nibName: "HighlightCell", bundle: nil),
            forCellWithReuseIdentifier: "HighlightCell")
    }
    
    private func configCollectionView() {
        collectionViewHighlights.addShadow()
        if let layout = collectionViewHighlights.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            let inset: CGFloat = calculateSectionInset()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: inset)
            layout.itemSize = CGSize(width: layout.collectionView!.frame.size.width, height: layout.collectionView!.frame.size.height)
        }
        collectionViewHighlights.isPagingEnabled = true
        collectionViewHighlights.showsHorizontalScrollIndicator = false

    }
    
    private func calculateSectionInset() -> CGFloat {
        return 100
    }
    
    private func observeErrors() {
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.alert(message: message)
                }
            }
        }
    }
    
    private func bindCollectionView() {
        /*
         update the collection when get data
         */
        viewModel.highlightsObservable
            .skip(first)
            .bind(to: collectionViewHighlights
                    .rx
                    .items(cellIdentifier: "HighlightCell", cellType: HighlightCell.self)) { (row, data, cell) in
                self.configureCell(cell: cell, data: data, row: row)
            }.disposed(by: bag)
        
        /*
         config the page control after get data
         */
        viewModel.highlightsObservable
            .skip(first)
            .bind(onNext: { _ in
                self.configPageControl()
            }).disposed(by: bag)
        
        /*
         get the carrousel item click
         */
        collectionViewHighlights.rx.modelSelected(Highlight.self)
            .subscribe(onNext: { item in
                self.callWebsite(item: item)
            }).disposed(by: bag)
        
        /*
         get the carrousel scroll action
         */
        collectionViewHighlights.rx.didScroll.subscribe(onNext: { _ in
            let center = CGPoint(x: self.collectionViewHighlights.contentOffset.x +
                                    (self.collectionViewHighlights.frame.width / 2), y: (self.collectionViewHighlights.frame.height / 2))
            if let indexPath = self.collectionViewHighlights.indexPathForItem(at: center) {
                self.pageControl.currentPage = indexPath.row
                self.counter = indexPath.row
            }
        }).disposed(by: bag)
        
    }
       
    private func bindTableView() {
        viewModel.newsObservable
            .skip(first)
            .bind(to: tableViewNews
                    .rx
                    .items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) { (row, data, cell) in
                self.configureCell(cell: cell, data: data, row: row)
            }.disposed(by: bag)
    }
    
    private func callWebsite(item: Highlight) {
        if let url = URL(string: item.url ?? "") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    private func configPageControl() {
        self.pageControl.numberOfPages = self.viewModel.highlightCount
        self.pageControl.hidesForSinglePage = true
        initPageControlTimer()
    }
    
    private func initPageControlTimer() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(
                timeInterval: 3.0,
                target: self,
                selector: #selector(self.changeImage),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    @objc func changeImage() {
        if counter < viewModel.highlightCount {
            scrollToItem(animated: true)
            counter += 1
        } else {
            counter = 0
            scrollToItem(animated: false)
            counter = 1
        }
    }
        
    private func scrollToItem(animated: Bool) {
        let index = IndexPath.init(item: counter, section: 0)
        self.collectionViewHighlights.scrollToItem(at: index, at: .centeredHorizontally, animated: animated)
        pageControl.currentPage = counter
    }
    
    private func setupRefresher() {
        refreshControl.tintColor = .lightGray
        tableViewNews.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData()
    }
    
    private func hideLoading() {
        LoadingView.hide()
        if (refreshControl.isRefreshing) {
            refreshControl.endRefreshing()
        }
    }
    
    private func configureCell(cell: HighlightCell, data: Highlight, row: Int) {
        cell.ivHighlight.imageFromUrl(urlString: data.imageURL ?? "")
        cell.ivHighlight.bounds = self.collectionViewHighlights.bounds
        cell.lblTitle.text = data.title
    }
    
    private func configureCell(cell: NewsCell, data: News, row: Int) {
        cell.ivNews.imageFromUrl(urlString: data.imageURL ?? "")
        cell.lblTitle.text = data.title
        cell.lblDescription.text = data.feedDescription
        cell.lblPublishedAt.text = data.publishedAt?.toDate().string()
        cell.lblAuthor.text = data.author
    }
    
    private func fetchData() {
        viewModel.fetchHighlightsData()
        viewModel.fetchNewsData(currentPage: 1, perPage: 20, publishedAt: "")
    }

}


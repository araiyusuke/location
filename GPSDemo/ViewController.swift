//
//  ViewController.swift
//  GPSDemo
//
//  Created by yusukearai on 2016/09/15.
//  Copyright © 2016年 yusuke arai. All rights reserved.
//

import UIKit
import CoreLocation/** @追加 */

class ViewController: UIViewController , CLLocationManagerDelegate/** @追加 */{
    
    var mLocationManager:CLLocationManager! /** @追加 */

    override func viewDidLoad() {
        super.viewDidLoad()
        mLocationManager = CLLocationManager() /** @追加 */
        mLocationManager.delegate = self /** @追加 */

        // まだ認証が得られていない場合は、認証ダイアログを表示.
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined  {
            mLocationManager.requestAlwaysAuthorization()
        }
        
        // 取得精度の設定.
        mLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        // 取得頻度の設定.
        mLocationManager.distanceFilter = 10
    
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        // 現在位置を「許可しない」設定にしている。
        case .Restricted, .Denied:
            let alert: UIAlertController = UIAlertController(title: nil, message: "このアプリは位置情報を許可にする必要があります。", preferredStyle:  UIAlertControllerStyle.Alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "変更", style: UIAlertActionStyle.Default, handler:{
                (action: UIAlertAction!) -> Void in
                // アプリ設定画面へ
                let url = NSURL(string:UIApplicationOpenSettingsURLString)
                UIApplication.sharedApplication().openURL(url!)
            })
            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
            })
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
            
        // 未設定
        case .NotDetermined:
            if mLocationManager.respondsToSelector(#selector(CLLocationManager.requestWhenInUseAuthorization)){
                // iOS8ではアクセス許可のリクエストをする。
                mLocationManager.requestWhenInUseAuthorization()
            }else{
                // iOS7では位置情報取得処理を開始することでアクセス許可のリクエストをする
                mLocationManager.startUpdatingLocation()
            }
            
        // 許可済み
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            mLocationManager.startUpdatingLocation()
            
        }
    }

    
    // 位置情報取得成功時に呼ばれます
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("緯度：\(manager.location!.coordinate.latitude)")
        print("経度：\(manager.location!.coordinate.longitude)")
    }
    
    // 位置情報取得失敗時に呼ばれます
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError){
        print(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


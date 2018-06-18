//
// Bluetooth.swift
//
// Copyright (c) 2015-2016 Damien (http://delba.io)
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
//

#if PERMISSION_BLUETOOTH
import CoreBluetooth

internal let BluetoothManager = CBPeripheralManager(
    delegate: Permission.bluetooth,
    queue: nil,
    options: [CBPeripheralManagerOptionShowPowerAlertKey: false]
)

extension Permission {
    var statusBluetooth: PermissionStatus {
        switch CBPeripheralManager.authorizationStatus() {
        case .restricted: return .disabled
        case .denied: return .denied
        case .notDetermined, .authorized: break
        }
        
        guard UserDefaults.standard.stateBluetoothManagerDetermined else { return .notDetermined }
        
        switch BluetoothManager.state {
        case .unsupported, .poweredOff: return .disabled
        case .unauthorized: return .denied
        case .poweredOn: return .authorized
        case .resetting, .unknown:
            return UserDefaults.standard.statusBluetooth ?? .notDetermined
        }
    }
    
    func requestBluetooth(_ callback: Callback?) {
        UserDefaults.standard.requestedBluetooth = true
        
        BluetoothManager.request(self)
    }
}

extension Permission: CBPeripheralManagerDelegate {
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        UserDefaults.standard.stateBluetoothManagerDetermined = true
        UserDefaults.standard.statusBluetooth = statusBluetooth
        
        guard UserDefaults.standard.requestedBluetooth else { return }
        
        callback?(statusBluetooth)
        
        UserDefaults.standard.requestedBluetooth = false
    }
}

extension CBPeripheralManager {
    func request(_ photosPermission: Permission) {
        guard case .poweredOn = state else { return }
        
        startAdvertising(nil)
        stopAdvertising()
    }
}
#endif

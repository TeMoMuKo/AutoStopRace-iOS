//  ImageRow.swift
//  Eureka ( https://github.com/xmartlabs/Eureka )
//
//  Copyright (c) 2016 Xmartlabs SRL ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import Eureka

public struct ImageRowSourceTypes : OptionSet {
    
    public let rawValue: Int
    public var imagePickerControllerSourceTypeRawValue: Int { return self.rawValue >> 1 }
    
    public init(rawValue: Int) { self.rawValue = rawValue }
    init(_ sourceType: UIImagePickerControllerSourceType) { self.init(rawValue: 1 << sourceType.rawValue) }
    
    public static let PhotoLibrary  = ImageRowSourceTypes(.photoLibrary)
    public static let Camera  = ImageRowSourceTypes(.camera)
    public static let All: ImageRowSourceTypes = [Camera, PhotoLibrary]
    
}

extension ImageRowSourceTypes {
    
    // MARK: Helpers
    
    var localizedString: String {
        switch self {
        case ImageRowSourceTypes.Camera:
            return NSLocalizedString("image_source_type_camera", comment: "")
        case ImageRowSourceTypes.PhotoLibrary:
            return NSLocalizedString("image_source_photo_library", comment: "")
        default:
            return ""
        }
    }
}

public enum ImageClearAction {
    case no
    case yes(style: UIAlertActionStyle)
}

//MARK: Row

open class _ImageRow<Cell: CellType>: SelectorRow<Cell, ImagePickerController> where Cell: BaseCell, Cell: TypedCellType, Cell.Value == UIImage {
    
    
    open var sourceTypes: ImageRowSourceTypes
    open internal(set) var imageURL: URL?
    open var clearAction = ImageClearAction.yes(style: .destructive)
    
    private var _sourceType: UIImagePickerControllerSourceType = .camera
    
    public required init(tag: String?) {
        sourceTypes = .All
        super.init(tag: tag)
        presentationMode = .presentModally(controllerProvider: ControllerProvider.callback { return ImagePickerController() }, onDismiss: { [weak self] vc in
            self?.select()
            vc.dismiss(animated: true)
        })
        self.displayValueFor = nil
        
    }
    
    // copy over the existing logic from the SelectorRow
    func displayImagePickerController(_ sourceType: UIImagePickerControllerSourceType) {
        if let presentationMode = presentationMode, !isDisabled {
            if let controller = presentationMode.makeController(){
                controller.row = self
                controller.sourceType = sourceType
                onPresentCallback?(cell.formViewController()!, controller)
                presentationMode.present(controller, row: self, presentingController: cell.formViewController()!)
            }
            else{
                _sourceType = sourceType
                presentationMode.present(nil, row: self, presentingController: cell.formViewController()!)
            }
        }
    }
    
    open override func customDidSelect() {
        guard !isDisabled else {
            super.customDidSelect()
            return
        }
        deselect()
        var availableSources: ImageRowSourceTypes = []
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let _ = availableSources.insert(.PhotoLibrary)
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let _ = availableSources.insert(.Camera)
        }
        
        sourceTypes.formIntersection(availableSources)
        
        if sourceTypes.isEmpty {
            super.customDidSelect()
            return
        }
        
        // now that we know the number of actions aren't empty
        let sourceActionSheet = UIAlertController(title: nil, message: selectorTitle, preferredStyle: .actionSheet)
        guard let tableView = cell.formViewController()?.tableView  else { fatalError() }
        if let popView = sourceActionSheet.popoverPresentationController {
            popView.sourceView = tableView
            popView.sourceRect = tableView.convert(cell.accessoryView?.frame ?? cell.contentView.frame, from: cell)
        }
        createOptionsForAlertController(sourceActionSheet)
        if case .yes(let style) = clearAction, value != nil {
            let clearPhotoOption = UIAlertAction(title: NSLocalizedString("remove_photo", comment: ""), style: style, handler: { [weak self] _ in
                self?.value = nil
                self?.imageURL = nil
                self?.updateCell()
            })
            sourceActionSheet.addAction(clearPhotoOption)
        }
        // check if we have only one source type given
        if sourceActionSheet.actions.count == 1 {
            if let imagePickerSourceType = UIImagePickerControllerSourceType(rawValue: sourceTypes.imagePickerControllerSourceTypeRawValue) {
                displayImagePickerController(imagePickerSourceType)
            }
        } else {
            let cancelOption = UIAlertAction(title: NSLocalizedString("cancel_photo", comment: ""), style: .cancel, handler:nil)
            sourceActionSheet.addAction(cancelOption)
            
            if let presentingViewController = cell.formViewController() {
                presentingViewController.present(sourceActionSheet, animated: true)
            }
        }
    }
    
    open override func prepare(for segue: UIStoryboardSegue) {
        super.prepare(for: segue)
        guard let rowVC = segue.destination as? ImagePickerController else {
            return
        }
        rowVC.sourceType = _sourceType
    }
    
    open override func customUpdateCell() {
        super.customUpdateCell()
        cell.accessoryType = .none
        if let image = self.value {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
            imageView.clipsToBounds = true
            cell.accessoryView = imageView
        }
        else{
            cell.accessoryView = nil
        }
    }
    
    
}

extension _ImageRow {
    
    //MARK: Helpers
    
    func createOptionForAlertController(_ alertController: UIAlertController, sourceType: ImageRowSourceTypes) {
        guard let pickerSourceType = UIImagePickerControllerSourceType(rawValue: sourceType.imagePickerControllerSourceTypeRawValue), sourceTypes.contains(sourceType) else { return }
        let option = UIAlertAction(title: NSLocalizedString(sourceType.localizedString, comment: ""), style: .default, handler: { [weak self] _ in
            self?.displayImagePickerController(pickerSourceType)
        })
        alertController.addAction(option)
    }
    
    func createOptionsForAlertController(_ alertController: UIAlertController) {
        createOptionForAlertController(alertController, sourceType: .Camera)
        createOptionForAlertController(alertController, sourceType: .PhotoLibrary)
    }
}

/// A selector row where the user can pick an image
public final class ImageRow : _ImageRow<PushSelectorCell<UIImage>>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}


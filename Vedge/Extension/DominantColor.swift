import UIKit
import CoreImage
import SwiftUI

extension UIImage {
    func mostSaturatedColor(resizedWidth: Int = 70, resizedHeight: Int = 40) -> Color? {
        guard let cgImage = self.cgImage else { return nil }

        // 리사이즈된 이미지 데이터 추출
        let width = resizedWidth
        let height = resizedHeight
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let totalBytes = height * bytesPerRow
        
        // RGBA 값을 저장할 배열
        var pixelData = [UInt8](repeating: 0, count: totalBytes)
        
        // 리사이즈된 이미지 만들기
        let context = CGContext(data: &pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        // 이미지를 리사이즈하여 context에 렌더링
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // 변수 초기화: 가장 높은 채도와 그에 해당하는 색상
        var maxSaturation: CGFloat = 0
        var saturatedColor: UIColor?
        
        // 픽셀 순회 (리사이즈된 이미지 기준)
        for x in 0..<width {
            for y in 0..<height {
                let pixelIndex = (y * bytesPerRow) + (x * bytesPerPixel)
                
                let r = CGFloat(pixelData[pixelIndex]) / 255.0
                let g = CGFloat(pixelData[pixelIndex + 1]) / 255.0
                let b = CGFloat(pixelData[pixelIndex + 2]) / 255.0
                

                let a = CGFloat(pixelData[pixelIndex + 3]) / 255.0
                
                let color = UIColor(red: r, green: g, blue: b, alpha: a)
                
                // 채도 계산
                var hue: CGFloat = 0
                var saturation: CGFloat = 0
                var brightness: CGFloat = 0
                color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
                
                // 채도가 가장 높은 색상 업데이트
                if saturation > maxSaturation {
                    maxSaturation = saturation
                    saturatedColor = color
                }
            }
        }
        
        // 가장 채도가 높은 색상을 SwiftUI Color로 반환
        if let saturatedColor = saturatedColor {
            return Color(saturatedColor)
        }
        
        return nil
    }
    func dominantColor() -> Color? {
        guard let cgImage = self.cgImage else { return nil }

              let inputImage = CIImage(cgImage: cgImage)
              let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
              guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
              guard let outputImage = filter.outputImage else { return nil }

              var bitmap = [UInt8](repeating: 0, count: 4)
              let context = CIContext(options: [.workingColorSpace: kCFNull!])
              context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        let r = Float(bitmap[0])
        let g = Float(bitmap[1])
        let b = Float(bitmap[2])
        
        if r + g + b > 480 || r + g + b < 128 {
            return self.mostSaturatedColor();
        }

        // UIColor -> SwiftUI Color 변환
        return Color(
            red: Double(bitmap[0]) / 255,
            green: Double(bitmap[1]) / 255,
            blue: Double(bitmap[2]) / 255,
            opacity: Double(bitmap[3]) / 255
        )
    }
}

import UIKit

public class DrawView: UIView {

  // MARK: - Instance Properties
  
  public var lineColor: UIColor = .black
  public var lineWidth: CGFloat = 5.0
  public var lines: [LineShape] = []

  @IBInspectable public var scaleX: CGFloat = 1 {
    didSet { applyTransform() }
  }
  
  @IBInspectable public var scaleY: CGFloat = 1 {
    didSet { applyTransform() }
  }
  
  private func applyTransform() {
    layer.sublayerTransform = CATransform3DMakeScale(scaleX, scaleY, 1)
  }

  // MARK: - UIResponder
  
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let point = touches.first?.location(in: self) else {
      return
    }
    
    let line = LineShape(color: lineColor, width: lineWidth, startPoint: point)
    lines.append(line)
    layer.addSublayer(line)
  }

  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let point = touches.first?.location(in: self), bounds.contains(point),
      let currentLine = lines.last else {
        return
    }
    currentLine.addPoint(point)
  }

  // MARK: - Actions
  
  public func animate() {
    guard let sublayers = layer.sublayers, sublayers.count > 0 else { return }
    
    sublayers.forEach { $0.removeAllAnimations() }
    UIView.animate(withDuration: 0.3) {
      CATransaction.begin()
      self.setSublayersStrokeEnd(to: 0.0)
      self.animateStrokeEnds(of: sublayers, at: 0)
      CATransaction.commit()
    }
  }

  private func setSublayersStrokeEnd(to value: CGFloat) {
    layer.sublayers?.forEach {
      guard let shapeLayer = $0 as? CAShapeLayer else { return }
      
      shapeLayer.strokeEnd = 0.0
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.fromValue = value
      animation.toValue = value
      animation.fillMode = .forwards
      shapeLayer.add(animation, forKey: nil)
    }
  }

  private func animateStrokeEnds(of layers: [CALayer], at index: Int) {
    guard index < layers.count else { return }
    
    let currentLayer = layers[index]
    CATransaction.begin()
    CATransaction.setCompletionBlock { [weak self] in
      currentLayer.removeAllAnimations()
      self?.animateStrokeEnds(of: layers, at: index + 1)
    }
    
    if let shapeLayer = currentLayer as? CAShapeLayer {
      shapeLayer.strokeEnd = 1.0
      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.duration = 1.0
      animation.fillMode = .forwards
      animation.fromValue = 0.0
      animation.toValue = 1.0
      shapeLayer.add(animation, forKey: nil)
    }
    CATransaction.commit()
  }
  
  public func copyLines(from source: DrawView) {
    layer.sublayers?.removeAll()
    lines = source.lines.deepCopy()
    lines.forEach { layer.addSublayer($0) }
  }

  public func clear() {
    lines = []
    layer.sublayers?.removeAll()
  }
}

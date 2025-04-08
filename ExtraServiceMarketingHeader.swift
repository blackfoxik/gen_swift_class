import Foundation
import ObjectMapper

private enum ExtraServiceMarketingHeaderKey: String {
  case headerImage
  case tags
  case text1
  case text2
  case text3
  case footer
}

public class ExtraServiceMarketingHeader: BaseWidget {

  public var headerImage: String?
  public var tags: [TagWidget]
  public var text1: WidgetText
  public var text2: WidgetText
  public var text3: WidgetText
  public var footer: BaseWidget

  required init?(map: Map) {
      super.init(map: map)

      guard self.type == "extraServiceMarketingHeader" else {
          return nil
      }
  }

  public required init() {
      fatalError("init() has not been implemented")
  }

  override public func mapping(map: Map) {
     super.mapping(map: map)

     self.headerImage <- map[ExtraServiceMarketingHeaderKey.headerImage.rawValue]
     self.tags <- map[ExtraServiceMarketingHeaderKey.tags.rawValue]
     self.text1 <- map[ExtraServiceMarketingHeaderKey.text1.rawValue]
     self.text2 <- map[ExtraServiceMarketingHeaderKey.text2.rawValue]
     self.text3 <- map[ExtraServiceMarketingHeaderKey.text3.rawValue]
     self.footer <- map[ExtraServiceMarketingHeaderKey.footer.rawValue]
  }
}
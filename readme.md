## To use call:
```bash     
ruby gen_swift_class.rb source.txt
```

gen_swift_class.rb
generates enum keys and class in swift

#### Rules:
first line contains class name and its type with ":" delimeter
class_name: class_type

the rest lines considers as properties with the same rule:
property_name: property_type

#### Example:
if source file contains the following content:

ExtraServiceMarketingHeader: BaseWidget
headerImage: String?
tags: [TagWidget]
text1: WidgetText
text2: WidgetText
text3: WidgetText
footer: BaseWidget

the output file will be:
ExtraServiceMarketingHeader.swift

with the content:

```swift

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
```

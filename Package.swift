import PackageDescription

let package = Package(
    name: "ZXFoundation"
)

products.append(
    Product(
        name: "ZXFoundation",
        type: .Library(.Dynamic),
        modules: "ZXFoundation"
    )
)

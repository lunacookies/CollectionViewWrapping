import Foundation

struct Item: Hashable {
	var description: String
	var isIndented = false
}

let testData = [
	UUID(): Item(description: "Aenean sit amet blandit est. Aliquam in dui ut urna hendrerit efficitur vitae tristique orci. Vivamus mollis ex ut justo fringilla, eu iaculis sem sodales."),
	UUID(): Item(description: "Maecenas ac vehicula ante. Mauris ut elit quis felis rutrum ullamcorper ut non enim. Vivamus feugiat turpis eget tortor dapibus volutpat."),
	UUID(): Item(description: "Nunc nec nulla ullamcorper, lobortis mi tempus, faucibus orci. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."),
	UUID(): Item(description: "Nulla commodo elit leo, in sagittis purus vestibulum et. Quisque ut varius augue. Sed tincidunt interdum cursus. Ut venenatis lectus et vehicula maximus. Suspendisse id libero scelerisque, aliquam lorem et, mollis est."),
]

import Foundation

struct ArrayOfSections {
    let sections: [Section]
 
    func getSectionAtIndex(_ index: Int) -> Section? {
        sections.first { $0.position == index }
    }
 
    func allSorted() -> [Section] {
        return sections.sorted(by: {$0.position > $1.position})
    }
    
    func sectionBy(name: String) -> Section? {
        return sections.filter {$0.name == name}.first
    }
}

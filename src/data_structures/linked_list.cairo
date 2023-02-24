use option::OptionTrait;

const ZERO_USIZE: usize = 0_usize;
const ZERO_FELT: felt = 0;

struct Node {
    value: felt,
    next: Option::<Box::<Node>>
}

trait NodeTrait {
    fn new() -> Node;
    fn with_value(value: felt, next: Option::<Box::<Node>>) -> Node;
}

impl NodeImpl of NodeTrait {
    fn new() -> Node {
        let mut next = Option::<Box::<Node>>::None(());
        Node { 
            value: ZERO_FELT,
            next
        }
    }

    fn with_value(value: felt, next: Option::<Box::<Node>>) -> Node {
        Node { 
            value: value, 
            next: next
        }
    }
}

struct LinkedList {
    head: Option::<Node>,
    len: usize
}

trait LinkedListTrait {
    fn new() -> LinkedList;
    fn add(ref self: LinkedList, value: felt);
    fn len(self: @LinkedList) -> usize;
    fn is_empty(self: @LinkedList) -> bool;
}

impl LinkedListImpl of LinkedListTrait {
    #[inline(always)]
    fn new() -> LinkedList {
        LinkedList { head: Option::None(()), len: 0_usize }
    }

    fn add(ref self: LinkedList, value: felt) {
        if self.is_empty() {
            let next = Option::<Box::<Node>>::None(());
            let head = NodeTrait::with_value(value, next);
            self = LinkedList { head: Option::Some::<Node>((head)), len: 1_usize };
        } else {
            NodeTrait::new(); 
        }
    }

    fn len(self: @LinkedList) -> usize {
        *self.len
    }
    
    fn is_empty(self: @LinkedList) -> bool {
        self.len() == ZERO_USIZE
    }
}

impl NodeDrop of Drop::<Node>;
impl NodeBoxDrop of Drop::<Box::<Node>>;
impl NodeOptionBoxDrop of Drop::<Option::<Box::<Node>>>;

impl LinkedListDrop of Drop::<LinkedList>;
impl LinkedListOptionNodeDrop of Drop::<Option::<Node>>;


fn main() -> felt {
    let mut list = LinkedListTrait::new();
    1
}
pragma solidity ^0.8.7;

contract Set {
    address[] internal items;
    uint internal items_length = 0;

    // 1-based indexing into the array. 0 represents non-existence.
    mapping(address => uint256) indexOf;

    function add(address value) internal {
        if (indexOf[value] == 0) {
            if (items_length == items.length) {
                items.push(value);
            } else {
                items[items_length] = value;
            }
            
            items_length++;
            indexOf[value] = items_length;
        }
    }

    function remove(address value) internal {
        uint256 index = indexOf[value];

        if (index > 0) {
            // move the last item into the index being vacated
            address lastValue = items[items_length - 1];
            items[index - 1] = lastValue;  // adjust for 1-based indexing
            indexOf[lastValue] = index;

            items_length--;
            indexOf[value] = 0;
        }
    }

    function destroy() internal {
        for (uint i = 0; i < items_length; ++i) {
            indexOf[items[i]] = 0;
        }
        delete items;
        items_length = 0;
    }

    function contains(address value) internal view returns (bool) {
        return indexOf[value] > 0;
    }

    function count() internal view returns (uint256) {
        return items_length;
    }
}

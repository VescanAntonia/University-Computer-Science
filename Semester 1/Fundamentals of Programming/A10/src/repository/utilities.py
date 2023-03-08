from copy import deepcopy


class IterableData:
    def __init__(self, new_list=None):
        if new_list is None:
            new_list = []
        self._current_list = new_list

    def __len__(self):
        return len(self._current_list)

    def __setitem__(self, key, value):
        self._current_list[key] = value

    def __getitem__(self, item):
        return self._current_list[item]

    def __delitem__(self, key):
        del self._current_list[key]

    def __iter__(self):
        self.key = -1
        return self

    def __next__(self):
        self.key += 1
        if self.key >= len(self._current_list):
            raise StopIteration
        return self._current_list[self.key]

    def list(self):
        return list(self._current_list.values())

    def append(self, item):
        self._current_list.append(item)

    def remove(self, key):
        del self._current_list[key]
        # self._current_list.remove(item)

    def update(self, key, new_element):
        self._current_list[key] = new_element


def filter_method(list_to_filter, filter_function_to_be_accomplished):
    filtered_list = []
    for element in list_to_filter:
        if filter_function_to_be_accomplished(element):
            filtered_list.append(element)
    return filtered_list


def sorting_algorithm(list_to_be_sorted, function_to_accomplish):
    """
    Shell Sort is an optimization of insertion sort that allows the exchange of items that are far apart. The idea is to
     arrange the list of elements so that, starting anywhere, taking every hth element produces a sorted list. Such a
      list is said to be h-sorted. It can also be thought of as h interleaved lists, each individually sorted.
      Beginning with large values of h allows elements to move long distances in the original list, reducing large
      amounts of disorder quickly, and leaving less work for smaller h-sort steps to do.
    :param list_to_be_sorted: the list that needs to be sorted
    :param function_to_accomplish: the function for comparison used while sorting
    :return: the sorted list using Shell Sort
    """
    gap_between_elements = len(list_to_be_sorted)//2
    while gap_between_elements > 0:
        for i in range(gap_between_elements, len(list_to_be_sorted)):
            element_to_compare = list_to_be_sorted[i]
            j = i
            while j >= gap_between_elements and function_to_accomplish(list_to_be_sorted[j-gap_between_elements], element_to_compare):
                list_to_be_sorted[j] = list_to_be_sorted[j-gap_between_elements]
                j -= gap_between_elements
            list_to_be_sorted[j] = element_to_compare
        gap_between_elements //= 2
    return list_to_be_sorted


# class IterableData:
#     def __init__(self):
#         self.data = []
#
#     def __iter__(self):
#         return iter(self.data)


import copy


class Graph:
    def __init__(self, nr_of_vertices, nr_of_edges):
        self._number_of_vertices = nr_of_vertices
        self._number_of_edges = nr_of_edges
        self._dictionary_for_in = {}
        self._dictionary_for_out = {}
        self._dictionary_costs = {}
        for i in range(nr_of_vertices):
            self._dictionary_for_in[i] = []
            self._dictionary_for_out[i] = []

    @property
    def get_the_number_of_vertices(self):
        return self._number_of_vertices

    @property
    def get_the_number_of_edges(self):
        return self._number_of_edges

    @property
    def get_the_dictionary_for_in(self):
        return self._dictionary_for_in

    @property
    def get_the_dictionary_for_out(self):
        return self._dictionary_for_out

    @property
    def get_dictionary_costs(self):
        return self._dictionary_costs

    def parse_vertices(self):
        list_of_vertices = list(self._dictionary_for_in.keys())
        for vertex in list_of_vertices:
            yield vertex

    def add_given_edge(self, first, second, cost):
        if first in self._dictionary_for_in[second]:
            return False
        elif second in self._dictionary_for_out[first]:
            return False
        elif (first, second) in self._dictionary_costs.keys():
            return False
        self._dictionary_for_in[second].append(first)
        self._dictionary_for_out[first].append(second)
        self._dictionary_costs[(first, second)] = cost
        self._number_of_edges += 1
        return True

    def check_if_edge_between_vertices(self, first_one, second_one):
        if first_one > self._number_of_vertices or second_one > self._number_of_vertices:
            raise ValueError(" The vertices does not exist, please enter valid vertices. ")
        elif first_one in self._dictionary_for_in[second_one]:
            return self._dictionary_costs[(first_one, second_one)]
        elif second_one in self._dictionary_for_out[first_one]:
            return self._dictionary_costs[(first_one, second_one)]
        else:
            return False

    def parse_edges_outbound(self, given_vertex):
        for i in self._dictionary_for_out[given_vertex]:
            yield i

    def parse_edges_inbound(self, given_vertex):
        for i in self._dictionary_for_in[given_vertex]:
            yield i

    def get_vertex_in_degree(self, given_vertex):
        if given_vertex not in self._dictionary_for_in.keys():
            return False
        return len(self._dictionary_for_in[given_vertex])

    def get_vertex_out_degree(self, given_vertex):
        if given_vertex not in self._dictionary_for_out.keys():
            return False
        return len(self._dictionary_for_out[given_vertex])

    def modify_the_cost_of_given_edge(self, first_vertex, second_vertex, new_cost):
        if (first_vertex, second_vertex) not in self._dictionary_costs.keys():
            return False
        self._dictionary_costs[(first_vertex,second_vertex)] = new_cost
        return True

    def remove_an_edge(self, first, second):
        if first not in self._dictionary_for_in.keys():
            return False
        elif second not in self._dictionary_for_out.keys():
            return False
        elif (first, second) not in self._dictionary_costs.keys():
            return False
        elif first not in self._dictionary_for_in[second]:
            return False
        elif second not in self._dictionary_for_out[first]:
            return False
        self._dictionary_for_in[second].remove(first)
        self._dictionary_for_out[first].remove(second)
        self._dictionary_costs.pop((first, second))
        self._number_of_edges -= 1
        return True

    def add_vertex(self, given_vertex):
        if given_vertex in self._dictionary_for_in.keys() and given_vertex in self._dictionary_for_out.keys():
            return False
        self._dictionary_for_in[given_vertex] = []
        self._dictionary_for_out[given_vertex] = []
        self._number_of_vertices += 1
        return True

    def remove_vertex(self, given_vertex_to_be_removed):
        if given_vertex_to_be_removed not in self._dictionary_for_in.keys() or given_vertex_to_be_removed not in self._dictionary_for_out.keys():
            return False
        self._dictionary_for_in.pop(given_vertex_to_be_removed)
        self._dictionary_for_out.pop(given_vertex_to_be_removed)
        for key in self._dictionary_for_in.keys():
            if given_vertex_to_be_removed in self._dictionary_for_in[key]:
                self._dictionary_for_in[key].remove(given_vertex_to_be_removed)
            elif given_vertex_to_be_removed in self._dictionary_for_out[key]:
                self._dictionary_for_out[key].remove(given_vertex_to_be_removed)
        new_list = list(self._dictionary_costs.keys())
        for el in new_list:
            if el[0] == given_vertex_to_be_removed or el[1] == given_vertex_to_be_removed:
                self._dictionary_costs.pop(el)
                self._number_of_edges -= 1
        self._number_of_vertices -= 1
        return True

    def copy_the_graph(self):
        return copy.deepcopy(self)


def read_a_graph_from_the_file(file_name):
    file = open(file_name, "r")
    line = file.readline()
    line = line.strip()
    vertices, edges = line.split(' ')
    graph = Graph(int(vertices), int(edges))
    line = file.readline().strip()
    while len(line) > 0:
        line = line.split(' ')
        if len(line) == 1:
            graph.get_the_dictionary_for_in[int(line[0])] = []
            graph.get_the_dictionary_for_out[int(line[0])] = []
        else:
            graph.get_the_dictionary_for_in[int(line[1])].append(int(line[0]))
            graph.get_the_dictionary_for_out[int(line[0])].append(int(line[1]))
            graph.get_dictionary_costs[(int(line[0]), int(line[1]))] = int(line[2])
        line = file.readline().strip()
    file.close()
    return graph


def write_graph_to_file(graph, output_file_name):
    file = open(output_file_name, "w")
    first_line = str(graph.get_the_number_of_vertices) + ' ' + str(graph.get_the_number_of_edges) + '\n'
    file.write(first_line)
    if len(graph.get_dictionary_costs) == 0 and len(graph.get_the_dictionary_for_in) == 0:
        raise ValueError("There is nothing that can be written!")
    for edge in graph.get_dictionary_costs.keys():
        new_line = "{} {} {}\n".format(edge[0], edge[1], graph.get_dictionary_costs[edge])
        file.write(new_line)
    for vertex in graph.get_the_dictionary_for_in.keys():
        if len(graph.get_the_dictionary_for_in[vertex]) == 0 and len(graph.get_the_dictionary_for_out[vertex]) == 0:
            new_line = "{}\n".format(vertex)
            file.write(new_line)
    file.close()

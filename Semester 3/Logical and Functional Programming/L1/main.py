

class Nod:
    def __init__(self, e):
        self.e = e
        self.nxt = None


class Lista:
    def __init__(self):
        self.prim = None


'''
crearea unei liste din valori citite pana la 0
'''


def creareLista():
    lista = Lista()
    lista.prim = creareLista_rec()
    return lista


def creareLista_rec():
    x = int(input("x="))
    if x == 0:
        return None
    else:
        nod = Nod(x)
        nod.urm = creareLista_rec()
        return nod


'''
tiparirea elementelor unei liste
'''


def tipar(lista):
    tipar_rec(lista.prim)


def tipar_rec(nod):
    if nod != None:
        print(nod.e)
        tipar_rec(nod.nxt)


# 5.b)Insert an element on a given position


def insert_element_on_position(given_list, n, pos, e, listaRez):
    if isEmpty(given_list):
        return listaRez
    elif n != pos:
        # first_el = given_list[0]
        # given_list.remove(given_list[0])
        n = n+1
        return insert_element_on_position(sublist(given_list), n, pos, e, insertElem(firstElem(given_list), listaRez))
        #return insert_element_on_position(sublist(given_list), pos, e)+[first_el]
    else:
        # first_el = given_list[0]
        #given_list.remove(given_list[0])

        #insertElem(e, listaRez)
        n = n+1
        return insert_element_on_position(sublist(given_list), n, pos, e, insertTheElement(e, firstElem(given_list), listaRez))
        #return insert_element_on_position(given_list, pos, e)+[e]+[first_el]


def isEmpty(lista):
    return lista == None


def insertElem(e, listaRezult):
    newNode = Nod(e)

    # 4. Check the Linked List is empty or not,
    #   if empty make the new node as head
    if listaRezult.prim is None:
        listaRezult.prim = newNode
    else:

        # 5. Else, traverse to the last node
        temp = listaRezult.prim
        while temp.nxt is not None:
            temp = temp.nxt

        # 6. Change the next of last node to new node
        temp.nxt = newNode
    return listaRezult


def insertTheElement(elem,elem2, listaRez):
    newNode = Nod(elem)

    # 4. Check the Linked List is empty or not,
    #   if empty make the new node as head
    if (listaRez.prim == None):
        listaRez.prim = newNode
    else:

        # 5. Else, traverse to the last node
        temp1 = listaRez.prim
        while (temp1.nxt != None):
            temp1 = temp1.nxt

        # 6. Change the next of last node to new node
        temp1.nxt = newNode
    listaRez = insertElem(elem2, listaRez)
    return listaRez


def firstElem(lista):
    return lista.e


def sublist(lista):
    return lista.nxt


# a)Determine the greatest common divisors of element from a list


def greater_common_div(my_given_list, d):
    if len(my_given_list) == 0 or len(my_given_list) == 1:
        return d
    else:
        first = my_given_list[0]
        second = my_given_list[1]
        my_given_list.remove(my_given_list[0])
        return greater_common_div(my_given_list, divisor(first, second))


def divisor(a, b):
    if b == 0:
        return a
    else:
        return divisor(b, a % b)


def a(lista):
    l = Lista()
    l.prim = None
    return insert_element_on_position(lista.prim, 0, 1, 7, l)


def main():
    lista = creareLista()
    tipar(a(lista))
    # my_list = [1, 2, 3, 4]
    # z = str([str(x) for x in my_list])
    # element_to_add = 7
    # position_to_add = 2
    # q = str([str(x) for x in insert_element_on_position(my_list, position_to_add, element_to_add)])
    # print("a)The initial list: " + z + ", The list after we add " + str(element_to_add) + " on position " +
    #     str(position_to_add) + " is: " + q)
    #
    # new_list = [2, 4, 6]
    # s = str([str(x) for x in new_list])
    # print("b)The greatest common divisor for the list: " + s + " is: " + str(greater_common_div(new_list, 1)))


main()

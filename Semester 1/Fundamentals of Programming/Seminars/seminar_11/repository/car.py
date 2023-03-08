class Car:
    def __init__(self, car_id, car_license_plate, car_brand, car_model):
        self.__car_id = car_id
        self.__car_license_plate = car_license_plate
        self.__car_brand = car_brand
        self.__car_model = car_model

    @property
    def get_car_id(self):
        """
        returns the Id of the client object
        """
        return self.__car_id

    @property
    def get_license_plate(self):
        """
        returns the name of the client object
        """
        return self.__car_license_plate

    @property
    def get_brand(self):
        """
        returns the Id of the client object
        """
        return self.__car_brand

    @property
    def get_model(self):
        """
        returns the name of the client object
        """
        return self.__car_model


def read_text_file(file_name):
    result = []
    try:
        f = open(file_name, "r")
        line = f.readline().strip()
        while len(line) > 0:
            line = line.split(";")
            result.append(Car(int(line[0]), line[1], line[2], line[3]))
            line = f.readline().strip()
        f.close()
    except IOError as e:
        """
            Here we 'log' the error, and throw it to the outer layers 
        """
        print("An error occured - " + str(e))
        raise e

    return result


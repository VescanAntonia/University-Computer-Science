#include <stdio.h>

void read_numbers(int a[], int *nr)
{
	//this function reads the vector of numbers
	int y = 1, x, i=1;
	printf("Enter the elements: ");
	while (y == 1)
	{
		scanf_s("%d", &x);
		if (x == 0)
			y=0;
		else
		{
			*nr = i;
			a[i] = x;
			i += 1;
		}
	}
}

int number_of_zeros(int a[], int n)
{
	//this function does the product of the elements of the vectors and counts the number of zeros from it
	int product = 1, counter=0;
	for (int i = 1; i <= n; i++)
		product = product * a[i];
	while (product)
	{
		if (product % 10 == 0)
			counter += 1;
		product = product / 10;
	}
	return counter;
}

int find_longest_subsequence(int a[], int n, int *starting_index, int *ending_index)
{
	//this function determies the longest subsequence in which the sum of every two elements is prime
	int sum = 0,j=1, max_nr=-99,current_max_nr=1, keep_going=1;
	for (int i = 1; i <= n; i++)
	{
		current_max_nr = 1;
		j = i;
		while(j<n &&keep_going==1)
		//for (j = i; j < n; j++)
		{
			//sum = 0;
			sum = a[j] + a[j + 1];
			if (check_if_prime(sum))
				current_max_nr += 1;
			else
				keep_going = 0;
			j += 1;

		}
		if (current_max_nr>=max_nr)
		{
			max_nr = current_max_nr;
			*starting_index = i;
			//if (j == n)
				//ending_position = n;
			//else
			*ending_index = j-1;
		}
	}
	//starting_position, ending_position;
}

int check_if_prime(number)
{
	//this function checks if a number is prime or not
	int is_prime = 1;
	for (int k = 2; k <= number / 2; k++)
		if (number % k == 0)
		{
			is_prime = 0;
		}
	return is_prime;
}

int decompose_the_number(int given_number_to_decompose, int*first, int *second)
{
	for (int i = 1; i < given_number_to_decompose; i++)
		for(int j=i;j<=given_number_to_decompose; j++)
			if (check_if_prime(i) && check_if_prime(j) && (i + j) == given_number_to_decompose)
			{
				first = i;
				second = j;
			}
	printf("%d + %d", first, second);

}

int main()
{
	//The menu for the user is printed and the user option is required
	printf("Please enter your option:");
	printf("\n 1.Insert the vector of the numbers");
	printf("\n 2. Read a sequence of natural numbers (sequence ended by 0) and determine the number of 0 digits of the product of the read numbers.");
	printf("\n 3. Given a vector of numbers, find the longest contiguous subsequence such that the sum of any two consecutive elements is a prime number.");
	printf("\n 4.Decompose a given even natural number, greater than 2, as a sum of two prime numbers");
	printf("\n 0.Exit");
	int still_running = 1, option, nr_of_zeros=0,starting_index=0, ending_index=0, nr=0, a[100], given_number, first_prime_number=0, second_prime_number=0;
	while (still_running == 1)  //the option to still run the program
	{
		printf("\n Your option: ");
		scanf_s("%d", &option); //this reads the user option from the keyboard;
		if (option == 1)
		{
			read_numbers(a, &nr);
			printf("The vector is:");
			for (int i = 1; i <= nr; i++)
			{
				printf("%d", a[i]);
				if(i<nr)
					printf("%c", ',');
			}
				
		}
		if (option == 2)
		{
			nr_of_zeros = number_of_zeros(a, nr);
			printf("The numbers of zeros are: %d", nr_of_zeros);
		}
		if (option == 3)
		{
			//int starting_index, ending_index;
			find_longest_subsequence(a, nr, &starting_index, &ending_index);
			printf("Longest subsequence with the required property is: ");
			for (int i = starting_index; i < ending_index; i++)
			{	printf("%d", a[i]);
				printf("%c", ',');
			}
			printf("%d", a[ending_index]);
			//printf("%d", starting_index);
			//printf("%d", ending_index);
		}
		if (option == 4)
		{
			printf("Enter the even number to be decomposed: ");
			scanf_s("%d", &given_number);
			if (given_number % 2 != 0 || given_number <= 2)
				printf("The given number is not even or is not greater than 2!");
			else
			{
				decompose_the_number(given_number, &first_prime_number, second_prime_number);
				//printf("%d + %d", first_prime_number, second_prime_number);
			}
		}
		if (option == 0)
			still_running = 0;
		if(option !=0&&option!=1&& option!=2&&option!=3&& option!=4)
			printf("Option not available!");

	}
	return 0;
}
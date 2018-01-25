#include <stdio.h>
#include <stdlib.h>

//example:
//k = 32
//input = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 401
int recursion(int* inputs, int current_val, int curr_index, int* result) {
	int difference = current_val - inputs[curr_index];
	if (difference == 0) {
		result[curr_index] = 1;
		return 1;
	}
	int i;
	for (i = curr_index - 1; i >= 0; i--)
		if (difference - inputs[i] >= 0) {
			if (recursion(inputs, difference, i, result)) {
				result[curr_index] = 1;
				return 1;
			}
		};
	return 0;
}

int main()
{
	int *inputs;
	int k, s, i;

	printf("Define k for equasion (there are going to be k + 1 inputs):\n");
	scanf("%d", &k);

	inputs = (int *)malloc(k * sizeof(int));

	printf("Define input of size %d:\n", k+1);
	i = 0;
	while (i < k && (scanf("%d,", &inputs[i]) == 1)) {
		i++;
	}
		
	// get final sum
	scanf("%d", &s);

	int* res = (int*)malloc(k * sizeof(int));
	
	for (i = 0; i < k; i++)
		res[i] = 0;

	// begin new recursions until result is obtained starting from highest element towards beggining
	for (i = k - 1; i >= 0; i--) 
		if(recursion(inputs, s, i, res))
			break;


	// print result
	for (i = 0; i < k; i++)
		printf("%d", res[i]);

	printf(" (");
	for (i = 0; i < k - 1; i++)
		printf("%d*%d + ", res[i], inputs[i]);
	printf("%d*%d = %d", res[k - 1], inputs[k - 1], s);
	printf(")\n");
	
	free(inputs);
	free(res);



	return 0;
}
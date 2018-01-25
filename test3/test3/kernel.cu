
//#include "cuda_runtime.h"
//#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

//cudaError_t addWithCuda(int *c, const int *a, const int *b, unsigned int size);


int recursion(int* inputs, int current_val, int curr_index, int* result) {
	if (current_val - inputs[curr_index] == 0) {
		result[curr_index] = 1;
		return 1;
	}
	int i;
	for (i = curr_index - 1; i >= 0; i--) {
		if (current_val - inputs[curr_index] - inputs[i] >= 0) {
			if (recursion(inputs, current_val - inputs[curr_index], i, result)) {
				result[curr_index] = 1;
				return 1;
			}
		}
	}
	return 0;
}

int main()
{
	int i = 0;
	///*
	int *inputs;
	int n;
	int s;

	printf("Define n for equasion (there are going to be 2^n + 1 inputs):\n");
	scanf("%d", &n);

	int k = (int)pow(2, n);
	inputs = (int *)malloc(k * sizeof(int));

	printf("Define input of size %d:\n", k+1);
	while (i < k && (scanf("%d,", &inputs[i]) == 1)) {
		i++;
	}
		

	scanf("%d", &s);
	//printf("%d\n", s);
	//printf("%d", input_size);
	//for (i = 0; i < k - 1; i++)
	//	printf("%d, ", inputs[i]);
	//printf("%d\n", inputs[k - 1]);
	//*/

	/*
	int inputs[4] = { 2, 5, 14, 28 };
	int k = 4;
	int s = 30;
	*/


	int* res = (int*)malloc(k * sizeof(int));
	
	for (i = 0; i < k; i++)
		res[i] = 0;

	for (i = k - 1; i >= 0; i--) 
		if(recursion(inputs, s, i, res))
			break;

	for (i = 0; i < k; i++)
		printf("%d", res[i]);

	printf(" (");
	for (i = 0; i < k - 1; i++)
		printf("%d*%d + ", res[i], inputs[i]);
	printf("%d*%d = %d", res[k - 1], inputs[k - 1], s);
	printf(")\n");
	

	return 0;
}



/*
cudaError_t addWithCuda(int *c, const int *a, const int *b, unsigned int size);

__global__ void addKernel(int *c, const int *a, const int *b)
{
    int i = threadIdx.x;
    c[i] = a[i] + b[i];
}

int main()
{
    const int arraySize = 5;
    const int a[arraySize] = { 1, 2, 3, 4, 5 };
    const int b[arraySize] = { 10, 20, 30, 40, 50 };
    int c[arraySize] = { 0 };

    // Add vectors in parallel.
    cudaError_t cudaStatus = addWithCuda(c, a, b, arraySize);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "addWithCuda failed!");
        return 1;
    }

    printf("{1,2,3,4,5} + {10,20,30,40,50} = {%d,%d,%d,%d,%d}\n",
        c[0], c[1], c[2], c[3], c[4]);

    // cudaDeviceReset must be called before exiting in order for profiling and
    // tracing tools such as Nsight and Visual Profiler to show complete traces.
    cudaStatus = cudaDeviceReset();
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceReset failed!");
        return 1;
    }

    return 0;
}

// Helper function for using CUDA to add vectors in parallel.
cudaError_t addWithCuda(int *c, const int *a, const int *b, unsigned int size)
{
    int *dev_a = 0;
    int *dev_b = 0;
    int *dev_c = 0;
    cudaError_t cudaStatus;

    // Choose which GPU to run on, change this on a multi-GPU system.
    cudaStatus = cudaSetDevice(0);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaSetDevice failed!  Do you have a CUDA-capable GPU installed?");
        goto Error;
    }

    // Allocate GPU buffers for three vectors (two input, one output)    .
    cudaStatus = cudaMalloc((void**)&dev_c, size * sizeof(int));
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMalloc failed!");
        goto Error;
    }

    cudaStatus = cudaMalloc((void**)&dev_a, size * sizeof(int));
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMalloc failed!");
        goto Error;
    }

    cudaStatus = cudaMalloc((void**)&dev_b, size * sizeof(int));
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMalloc failed!");
        goto Error;
    }

    // Copy input vectors from host memory to GPU buffers.
    cudaStatus = cudaMemcpy(dev_a, a, size * sizeof(int), cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!");
        goto Error;
    }

    cudaStatus = cudaMemcpy(dev_b, b, size * sizeof(int), cudaMemcpyHostToDevice);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!");
        goto Error;
    }

    // Launch a kernel on the GPU with one thread for each element.
    addKernel<<<1, size>>>(dev_c, dev_a, dev_b);

    // Check for any errors launching the kernel
    cudaStatus = cudaGetLastError();
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "addKernel launch failed: %s\n", cudaGetErrorString(cudaStatus));
        goto Error;
    }
    
    // cudaDeviceSynchronize waits for the kernel to finish, and returns
    // any errors encountered during the launch.
    cudaStatus = cudaDeviceSynchronize();
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceSynchronize returned error code %d after launching addKernel!\n", cudaStatus);
        goto Error;
    }

    // Copy output vector from GPU buffer to host memory.
    cudaStatus = cudaMemcpy(c, dev_c, size * sizeof(int), cudaMemcpyDeviceToHost);
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaMemcpy failed!");
        goto Error;
    }

Error:
    cudaFree(dev_c);
    cudaFree(dev_a);
    cudaFree(dev_b);
    
    return cudaStatus;
}
*/
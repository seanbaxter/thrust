#include <thrust/device_vector.h>
#include <thrust/reduce.h>
#include <thrust/scan.h>
#include <thrust/sequence.h>

#include <cuda_runtime_api.h>

#include <cstdio>
#include <cstdlib>

int run_gpu(std::size_t size)
{
  thrust::device_vector<int> data(size);
  thrust::sequence(data.begin(), data.end());
  thrust::exclusive_scan(data.cbegin(), data.cend(), data.begin());
  const auto result = thrust::reduce(data.cbegin(), data.cend());
  printf("%s %d\n", "run_gpu:", result);

  const auto errCheck = cudaGetLastError();
  printf("%s: [CUDA Error Check] %s\n",
         "run_gpu",
         cudaGetErrorString(errCheck));
  if (errCheck != cudaSuccess)
  {
    std::abort();
  }

  return result;
}

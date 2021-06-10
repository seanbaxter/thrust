#include "bar.h"

#include <cuda_runtime_api.h>

#include <cstdio>
#include <cstdlib>

extern int run_gpu(std::size_t);

BarDerived::~BarDerived() = default;

int BarDerived::run(std::size_t n)
{
  const int result = run_gpu(n);

  {
    const auto errCheck = cudaGetLastError();
    std::printf("%s: [CUDA Error Check 1] %s\n",
                "BarDerived::run",
                cudaGetErrorString(errCheck));
    std::fflush(stdout);
    if (errCheck != cudaSuccess)
    {
      std::abort();
    }
  }

  this->check(result);

  {
    const auto errCheck = cudaGetLastError();
    std::printf("%s: [CUDA Error Check 2] %s\n",
                "BarDerived::run",
                cudaGetErrorString(errCheck));
    std::fflush(stdout);
    if (errCheck != cudaSuccess)
    {
      std::abort();
    }
  }

  return result;
}

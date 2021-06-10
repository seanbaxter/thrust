#include "foo.h"

#include <cstddef>
#include <cstdio>
#include <cstdlib>

#include <cuda_runtime_api.h>

extern void unused_gpu();

void unused()
{
  unused_gpu(); // Defined in foo.cu
}

FooBase::~FooBase() = default;

void FooBase::check(int result)
{
  std::printf("%s %d\n", "FooBase::check:", result);

  const auto errCheck = cudaGetLastError();
  std::printf("%s: [CUDA Error Check] %s\n",
              "FooBase::check",
              cudaGetErrorString(errCheck));
  std::fflush(stdout);
  if (errCheck != cudaSuccess)
  {
    std::abort();
  }
}

int entry(FooBase &base, std::size_t n)
{
  return base.run(n); // Only implementation is in bar.cpp
}

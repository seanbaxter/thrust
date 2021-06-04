#include "bar_lib.h"

#include <thrust/device_vector.h>
#include <thrust/reduce.h>
#include <thrust/sequence.h>

#include <cstdint>

int bar(std::size_t size)
{
  thrust::device_vector<int> data(size);
  thrust::sequence(data.begin(), data.end());
  return thrust::reduce(data.cbegin(), data.cend());
}

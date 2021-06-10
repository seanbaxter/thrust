#include <thrust/device_vector.h>
#include <thrust/functional.h>

#include <cub/device/device_scan.cuh>

void unused()
{
  // Invoke the same signature of cub::DeviceScan::ExclusiveScan as in bar.cu.
  // This function is never executed, it only has to be defined in libfoo.
  const auto n = static_cast<std::size_t>(1024);
  thrust::device_vector<int> data(n);
  std::size_t                lvalue{};
  cub::DeviceScan::ExclusiveScan(nullptr,
                                 lvalue,
                                 data.begin(),
                                 data.begin(),
                                 thrust::plus<int>{},
                                 int{},
                                 int{});
}

#include "bar_lib.h"
#include "foo_lib.h"

#include <cstdint>
#include <cstdio>
#include <cstdlib>

int main()
{
  std::size_t size{1024};
  const auto foo_result = foo(size);
  printf("foo: %d\n", foo_result);
  const auto bar_result = bar(size);
  printf("bar: %d\n", bar_result);

  const bool result_valid = foo_result == 523776 && foo_result == bar_result;
  return result_valid ? EXIT_SUCCESS : EXIT_FAILURE;
}

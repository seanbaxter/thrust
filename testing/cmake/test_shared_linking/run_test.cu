#include "bar.h"
#include "foo.h"

#include <cstddef>
#include <cstdio>
#include <cstdlib>

int main()
{
  const std::size_t n{1024};

  BarDerived bar;
  const auto result = bar.run(n);

  using result_t = decltype(result);
  const auto expected_result = static_cast<result_t>(178433024);

  printf("%s %d\n", "main:", result);
  printf("%s %d\n", "expected:", result);

  return result == expected_result ? EXIT_SUCCESS : EXIT_FAILURE;
}

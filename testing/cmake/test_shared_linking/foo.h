#pragma once

#include "export.h"

#include <cstddef>

EXPORT void unused();

struct EXPORT FooBase
{
  virtual ~FooBase();
  virtual int run(std::size_t n) = 0;

protected:
  void check(int result);
};

EXPORT int entry(FooBase&, std::size_t);

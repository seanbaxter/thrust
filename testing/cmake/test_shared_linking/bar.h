#pragma once

#include "export.h"
#include "foo.h"

#include <cstddef>

struct EXPORT BarDerived : public FooBase
{
  ~BarDerived() override;
  int run(std::size_t n) override;
};


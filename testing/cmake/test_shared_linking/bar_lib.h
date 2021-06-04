#include <cstdint>

#ifdef _WIN32
#  ifdef BUILDING_DLL
#    define DLL_PUBLIC __declspec(dllexport)
#  else
#    define DLL_PUBLIC __declspec(dllimport)
#  endif
#else
#  define DLL_PUBLIC
#endif

DLL_PUBLIC int bar(std::size_t size);

AR ?= ar
CXX ?= g++
# CPP and CXXFLAGS from original Makefile
CPPFLAGS += -DPOSIX
CXXFLAGS += -fno-exceptions -fno-rtti -Wall -I . -I utp_config_lib
RANLIB ?= ranlib
LIBDIR ?= /usr/lib

name = libutp
# No versioning upstream since they only build static archive
major = 0
minor = 0.0
version = $(major).$(minor)

# Copy SRCS= from original Makefile
src = utp.cpp utp_utils.cpp
lo = $(addsuffix .lo,$(basename ${src}))
o = $(addsuffix .o,$(basename ${src}))

lib = so
ifeq ($(shell uname),Darwin)
	lib = dylib
endif

all: $(name).a $(name).$(lib)

%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) $< -o $@

$(name).a: $(o)
	$(AR) q $(name).a $(o)
	$(RANLIB) $(name).a

%.lo: %.cpp
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -fPIC $< -o $@

$(name).so: $(lo)
	$(CXX) $(LDFLAGS) -fPIC -shared $(lo) -Wl,-soname,$(name).so.$(major) -o $(name).so.$(version)
	ln -s $(name).so.$(version) $(name).so.$(major)
	ln -s $(name).so.$(version) $(name).so

$(name).dylib: $(lo)
	$(CXX) $(LDFLAGS) -fPIC -dynamiclib $(lo) -install_name $(LIBDIR)/$(name).$(major).dylib -o $(name).$(version).dylib
	ln -s $(name).$(version).dylib $(name).$(major).dylib
	ln -s $(name).$(version).dylib $(name).dylib

clean:
	-rm -f *.o *.lo *.so* *.a

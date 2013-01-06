# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/ramspeed/ramspeed-3.5.0-r1.ebuild,v 1.3 2012/12/01 18:20:27 blueness Exp $

EAPI="4"
inherit flag-o-matic toolchain-funcs

MY_PN="ramsmp"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Benchmarking for memory and cache"
HOMEPAGE="http://www.alasir.com/software/ramspeed/"
SRC_URI="http://www.alasir.com/software/${PN}/${MY_P}.tar.gz"

LICENSE="Alasir"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse pic"

src_configure(){
	local obj
	local arch_prefix=./

	use x86 && arch_prefix=i386/
	use amd64 && arch_prefix=amd64/

	tc-export CC AS

	#fix the stack
	append-ldflags -Wl,-z,noexecstack
	obj=( ramsmp.o ${arch_prefix}{fltmark,fltmem,intmark,intmem}.o )

	if use pic; then
		append-ldflags -nopie
	fi

	if use amd64; then
		sed -i \
			-e 's/call.*free/call\tfree@PLT/' \
			-e 's/call.*gettimeofday/call\tgettimeofday@PLT/' \
			-e 's/call.*malloc/call\tmalloc@PLT/' \
			${arch_prefix}/*.s
	fi

	if use x86; then
		obj=( "${obj[@]}" ${arch_prefix}{cpuinfo/cpuinfo_main,cpuinfo/cpuinfo_ext}.o )
	fi

	if use sse; then
		use x86 && append-flags "-DLINUX -DI386_ASM"
		use amd64 && append-flags "-DLINUX -DAMD64_ASM"
		obj=( "${obj[@]}" ${arch_prefix}{mmxmark,mmxmem,ssemark,ssemem}.o )
	fi

	echo "ramsmp: ${obj[@]}" > Makefile
}

src_install(){
	dobin ramsmp
	dosym /usr/bin/ramsmp /usr/bin/ramspeed
	dodoc HISTORY README
}

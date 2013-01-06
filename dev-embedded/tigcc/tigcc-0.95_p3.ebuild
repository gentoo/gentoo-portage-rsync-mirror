# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/tigcc/tigcc-0.95_p3.ebuild,v 1.8 2012/04/30 02:53:44 vapier Exp $

inherit eutils

BASE_GCC="3.3.3"
BASE_BINUTILS="2.14"
GCC_VER=${BASE_GCC:0:3}
BIN_VER=${BASE_BINUTILS:0:4}
S=${WORKDIR}
DESCRIPTION="Cross compiler for Texas Instruments TI-89, TI-92(+) and V200 calculators"
HOMEPAGE="http://tigcc.ticalc.org"

# mirror://gentoo/${P}.tar.bz2 comes from http://tigcc.ticalc.org/linux/tigcc_src.tar.bz2
# which isn't that reliable

#All kernel mirrors in gentoo didn't have 2.14
#	mirror://kernel/linux/devel/binutils/binutils-${BASE_BINUTILS}.tar.bz2

SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gnu/gcc/releases/gcc-${BASE_GCC}/gcc-core-${BASE_GCC}.tar.bz2
	http://cdn.mirror.garr.it/mirrors/gnuftp/binutils/binutils-${BASE_BINUTILS}.tar.bz2
	http://members.chello.at/gerhard.kofler/kevin/ti89prog/libfargo.zip
	http://members.chello.at/gerhard.kofler/kevin/ti89prog/flashosa.zip"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=sys-devel/binutils-2.14.90.0.6-r1"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-devel/bison-1.875"

src_unpack() {
	unpack ${A}
	# start by patching binutils and gcc
	cd ${WORKDIR}/binutils-${BASE_BINUTILS}
	epatch ${S}/sources/gcc/gas-${BIN_VER}-tigcc-*.diff

	cd ${WORKDIR}/gcc-${BASE_GCC}
	epatch ${S}/sources/gcc/gcc-${BASE_GCC}-tigcc-*.diff

	# a68k didn't compile, this should fix it.
	cd ${S}
	epatch ${FILESDIR}/a68k-fix.patch

	# fixes a bug in tprbuilder, needed for 0.95_beta8-r1
	# epatch ${FILESDIR}/tprbuilder-fix.patch

	# make build directories for binutils and gcc
	mkdir -p ${WORKDIR}/build/binutils
	mkdir ${WORKDIR}/build/gcc
}

src_compile() {
	# build binutils
	cd ${WORKDIR}/build/binutils
	CFLAGS="$CFLAGS" ${WORKDIR}/binutils-${BASE_BINUTILS}/configure \
		--disable-serial-configure --target=m68k-coff --disable-shared \
		--enable-static --disable-multilib --disable-nls \
		|| die
	emake || die

	# build gcc
	cd ${WORKDIR}/build/gcc

	# --with-headers=${S}/tigcclib/include/c \
	CFLAGS="$CFLAGS" ${WORKDIR}/gcc-${BASE_GCC}/configure --target=m68k-coff \
		--with-gnu-as --with-as=${WORKDIR}/build/binutils/gas/as-new --with-gnu-ld \
		--disable-nls --disable-multilib --disable-shared --enable-static \
		--disable-threads \
		|| die
	# GCC compilations _is intended_ to fail on a certain point, don't worry about that.
	emake

	# build a68k assembler
	cd ${S}/sources/a68k/src
	emake -e || die

	# build ld-tigcc linker
	cd ${S}/sources/ld-tigcc
	emake -e || die

	# build tigcc front-end
	cd ${S}/sources/tigcc/src
	emake -e || die

	# build tprbuilder (TIGCC project builder)
	cd ${S}/sources/tprbuilder/src
	emake -e || die

	# build patcher (object file patcher)
	cd ${S}/sources/patcher/src
	emake -e || die

	# build parser
	cd ${S}/sources/parser/src
	emake -e || die

	# build tict tool suite
	cd ${S}/tt
	CFLAGS="$CFLAGS" ./makelinux.sh || die

	# patch the script that launches the documentation browser to point to the correct location
	sed "s:\$TIGCC/doc:/usr/share/doc/${P}:g" ${S}/tigcclib/doc/converter/tigccdoc > ${S}/tigcclib/doc/converter/tigccdoc.new
}

src_install() {
	#ENV_FILE=${D}/etc/env.d/gcc/ti-linux-gnu-${GCC_VER}
	ENV_FILE=${D}/etc/env.d/99tigcc

	# install documentation

	cd ${S}/tigcclib/doc/converter
	into /usr
	dodir /usr/bin
	newbin tigccdoc.new tigccdoc

	dodir /usr/share/doc/${PF}
	cd ${S}
	dodoc AUTHORS BUGS CHANGELOG COPYING DIRECTORIES HOWTO INSTALL README README.linux README.osX

	cd ${S}/tigcclib/doc
	dohtml -r html/*.html
	cp html/qt-assistant.adp ${D}/usr/share/doc/${PF}/html

	cd ${S}/sources/a68k
	docinto a68k
	dodoc docs/*.txt

	cd ${S}/sources/tigcc
	docinto tigcc
	dodoc AUTHORS COPYING ChangeLog README

	cd ${S}/sources/tprbuilder
	docinto tprbuilder
	dodoc AUTHORS COPYING ChangeLog README

	cd ${S}/sources/patcher
	docinto patcher
	dodoc AUTHORS COPYING ChangeLog README

	cd ${S}/sources/parser
	docinto parser
	dodoc AUTHORS COPYING ChangeLog README

	cd ${S}/tt
	docinto tools
	dodoc history.txt linux_readme.txt readme.txt tooldocs.txt

	exeinto /usr/ti-linux-gnu/tigcc-bin/${GCC_VER}
	# install gcc
	cd ${WORKDIR}/build/gcc
	doexe gcc/cc1
	newexe gcc/xgcc gcc
	dosym /usr/ti-linux-gnu/tigcc-bin/${GCC_VER}/gcc /usr/ti-linux-gnu/tigcc-bin/${GCC_VER}/ti-linux-gnu-gcc

	# install gas
	# exeinto /usr/ti-linux-gnu/bin <-- a symlink will be created so that gas resides in /usr/ti-linux-gnu/bin too
	cd ${WORKDIR}/build/binutils
	newexe gas/as-new as

	# install a68k
	cd ${S}/sources/a68k/src
	newexe A68k a68k

	# install ld-tigcc
	cd ${S}/sources/ld-tigcc
	doexe ld-tigcc
	doexe ar-tigcc

	# install tigcc
	cd ${S}/sources/tigcc/src
	doexe tigcc
	dosym /usr/ti-linux-gnu/tigcc-bin/${GCC_VER}/tigcc /usr/ti-linux-gnu/tigcc-bin/${GCC_VER}/ti-linux-gnu-tigcc

	# install tprbuilder
	cd ${S}/sources/tprbuilder/src
	doexe tprbuilder

	# install patcher
	cd ${S}/sources/patcher/src
	doexe patcher

	# install parser
	cd ${S}/sources/parser/src
	doexe parser

	# install tict tool suite
	cd ${S}/tt
	doexe linuxbin/*

	# install header files
	dodir /usr/include/tigcc
	cp -R ${S}/tigcclib/include/* ${D}/usr/include/tigcc
	dosym /usr/include/tigcc/asm/os.h /usr/include/tigcc/asm/OS.h

	insinto /usr/lib/gcc-lib/ti-linux-gnu/${GCC_VER}
	# install library
	cd ${S}/tigcclib
	doins lib/*
	cd ${WORKDIR}
	doins flashosa/flashos.a
	doins fargo.a

	dodir /usr/share/tigcc
	# copy example programs
	cp -r ${S}/examples ${D}/usr/share/tigcc

	# create TIGCC env variable
	dodir /etc/env.d/gcc
	# echo -e "TIGCC=\"/usr/ti-linux-gnu/tigcc-bin/${GCC_VER}\"" >> ${ENV_FILE}
	# echo -e "CC=\"tigcc\"" >> ${ENV_FILE}
	echo -e "TIGCC=\"/usr/ti-linux-gnu\"" >> ${ENV_FILE}
	echo -e "PATH=\"/usr/ti-linux-gnu/tigcc-bin/${GCC_VER}:/usr/ti-linux-gnu/bin\"" >> ${ENV_FILE}
	echo -e "ROOTPATH=\"/usr/ti-linux-gnu/tigcc-bin/${GCC_VER}:/usr/ti-linux-gnu/bin\"" >> ${ENV_FILE}
	echo -e "LDPATH=\"/usr/lib/gcc-lib/ti-linux-gnu/${GCC_VER}\"" >> ${ENV_FILE}

	# a cross-compiling gcc with hard-coded names has been built.
	# therefore, we must place some symlinks.
	dosym /usr/include/tigcc /usr/ti-linux-gnu/include
	dosym /usr/lib/gcc-lib/ti-linux-gnu/${GCC_VER} /usr/ti-linux-gnu/lib
	dosym /usr/share/doc/${PF} /usr/ti-linux-gnu/doc
	dosym /usr/ti-linux-gnu/tigcc-bin/${GCC_VER} /usr/ti-linux-gnu/bin
}

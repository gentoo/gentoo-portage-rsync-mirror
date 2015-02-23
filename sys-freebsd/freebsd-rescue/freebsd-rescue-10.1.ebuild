# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bsdmk freebsd toolchain-funcs

DESCRIPTION="FreeBSD's rescue binaries"
SLOT="0"
LICENSE="BSD zfs? ( CDDL )"

IUSE="atm netware nis zfs"

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~x86-fbsd"
	SRC_URI="mirror://gentoo/${UBIN}.tar.xz
			mirror://gentoo/${CONTRIB}.tar.xz
			mirror://gentoo/${LIB}.tar.xz
			mirror://gentoo/${BIN}.tar.xz
			mirror://gentoo/${SBIN}.tar.xz
			mirror://gentoo/${USBIN}.tar.xz
			mirror://gentoo/${GNU}.tar.xz
			mirror://gentoo/${SYS}.tar.xz
			mirror://gentoo/${LIBEXEC}.tar.xz
			mirror://gentoo/${RESCUE}.tar.xz
			zfs? ( mirror://gentoo/${CDDL}.tar.xz )"
fi

RDEPEND=""
DEPEND="sys-devel/flex
	app-arch/xz-utils[static-libs]
	sys-libs/ncurses[static-libs]
	dev-libs/expat[static-libs]
	app-arch/bzip2[static-libs]
	dev-libs/libedit[static-libs]
	dev-libs/libxml2:2[static-libs]
	dev-libs/openssl[static-libs]
	sys-libs/zlib[static-libs]
	sys-libs/readline[static-libs]
	=sys-freebsd/freebsd-lib-${RV}*[atm?,netware?]
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*
	zfs? ( =sys-freebsd/freebsd-cddl-${RV}* )"

S="${WORKDIR}/rescue"

pkg_setup() {
	use atm || mymakeopts="${mymakeopts} WITHOUT_ATM= "
	use netware || mymakeopts="${mymakeopts} WITHOUT_IPX= "
	use nis || mymakeopts="${mymakeopts} WITHOUT_NIS= "
	use zfs || mymakeopts="${mymakeopts} WITHOUT_CDDL= "
	mymakeopts="${mymakeopts} NO_PIC= "
}

src_prepare() {
	# As they are patches from ${WORKDIR} apply them by hand
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}"-10.0-zlib.patch
	epatch "${FILESDIR}/freebsd-sbin-bsdxml2expat.patch"
}

src_compile() {
	tc-export CC
	# crunchgen is now checks env MAKE.
	# Use to force BSD's make
	export MAKE=/usr/bin/make

	cd "${WORKDIR}/lib/libarchive"
	echo "#include <expat.h>" > bsdxml.h
	freebsd_src_compile
	export CC="${CC} -L${WORKDIR}/lib/libarchive"

	cd "${S}"
	freebsd_src_compile
}

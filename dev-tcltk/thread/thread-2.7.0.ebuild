# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/thread/thread-2.7.0.ebuild,v 1.12 2015/03/20 11:17:19 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils multilib

DESCRIPTION="Tcl Thread extension"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug gdbm"

DEPEND="
	dev-lang/tcl:0=[threads]
	gdbm? ( sys-libs/gdbm )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}${PV}

RESTRICT="test"

src_prepare() {
	# Search for libs in libdir not just exec_prefix/lib
	sed -i -e 's:${exec_prefix}/lib:${libdir}:' \
		aclocal.m4 || die "sed failed"

	sed -i -e "s/relid'/relid/" tclconfig/tcl.m4 || die

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-tclinclude="${EPREFIX}/usr/include"
		--with-tcl="${EPREFIX}/usr/$(get_libdir)"
	)
	use gdbm && myconf+=( --with-gdbm )
	use debug && myconf+=( --enable-symbols )
	autotools-utils_src_configure
}

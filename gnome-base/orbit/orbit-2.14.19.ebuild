# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/orbit/orbit-2.14.19.ebuild,v 1.7 2012/05/05 05:38:08 jdhore Exp $

EAPI="3"

inherit gnome2 toolchain-funcs

MY_PN="ORBit2"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="doc test"

RDEPEND=">=dev-libs/glib-2.8
	>=dev-libs/libIDL-0.8.2"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README* TODO"

pkg_setup() {
	if use test; then
		if ! use debug; then
			elog "USE=debug is required for the test feature. Auto-enabling."
		fi
		G2CONF="${G2CONF} --enable-debug"
	fi
}

src_prepare() {
	gnome2_src_prepare

	# Fix wrong process kill, bug #268142
	sed "s:killall lt-timeout-server:killall timeout-server:" \
		-i test/timeout.sh || die "sed 1 failed"

	# Do not mess with CFLAGS
	sed 's/-ggdb -O0//' -i configure.in configure || die "sed 2 failed"
}

src_compile() {
	# We need to unset IDL_DIR, which is set by RSI's IDL.  This causes certain
	# files to be not found by autotools when compiling ORBit.  See bug #58540
	# for more information.  Please don't remove -- 8/18/06
	unset IDL_DIR

	# We need to use the hosts IDL compiler if cross-compiling, bug #262741
	if tc-is-cross-compiler; then
		# check that host version is present and executable
		[ -x /usr/bin/orbit-idl-2 ] || die "Please emerge ~${CATEGORY}/${P} on the host system first"
		G2CONF="${G2CONF} --with-idl-compiler=/usr/bin/orbit-idl-2"
	fi

	# Parallel build fails from time to time, bug #273031
	MAKEOPTS="${MAKEOPTS} -j1"
	gnome2_src_compile
}

src_test() {
	# can fail in parallel, see bug #235994
	emake -j1 check || die "tests failed"
}

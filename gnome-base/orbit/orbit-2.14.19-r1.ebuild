# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/orbit/orbit-2.14.19-r1.ebuild,v 1.12 2012/05/09 01:35:12 aballier Exp $

EAPI="3"
GCONF_DEBUG="yes"
GNOME_ORG_MODULE="ORBit2"

inherit gnome2 toolchain-funcs autotools

DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://projects.gnome.org/ORBit2/"

LICENSE="GPL-2 LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc test"

RDEPEND=">=dev-libs/glib-2.8:2
	>=dev-libs/libIDL-0.8.2"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README* TODO"
	if use test; then
		if ! use debug; then
			elog "USE=debug is required for the test feature. Auto-enabling."
		fi
		G2CONF="${G2CONF} --enable-debug"
	fi
}

src_prepare() {
	# Fix wrong process kill, bug #268142
	sed "s:killall lt-timeout-server:killall timeout-server:" \
		-i test/timeout.sh || die "sed 1 failed"

	# Do not mess with CFLAGS
	sed 's/-ggdb -O0//' -i configure.in configure || die "sed 2 failed"

	if ! use test; then
		sed -i -e 's/test //' Makefile.am || die
	fi

	# Drop failing test, bug #331709
	sed -i -e 's/test-mem //' test/Makefile.am || die

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
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
	gnome2_src_configure
}

src_compile() {
	# Parallel build fails from time to time, bug #273031
	MAKEOPTS="${MAKEOPTS} -j1"
	gnome2_src_compile
}

src_test() {
	# can fail in parallel, see bug #235994
	emake -j1 check || die "tests failed"
}

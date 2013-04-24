# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-2.0.8-r1.ebuild,v 1.13 2013/04/24 17:38:39 jer Exp $

EAPI="2"
GCONF_DEBUG="yes"

inherit autotools eutils gnome2

DESCRIPTION="A simple network library."
HOMEPAGE="http://live.gnome.org/GNetLibrary"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="doc test"

# FIXME: automagic use of valgrind
RDEPEND=">=dev-libs/glib-2.6:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.2 )
	>=dev-libs/check-0.9.7"
# FIXME: check should only be needed with USE 'test', bug #349301
#	test? ( >=dev-libs/check-0.9.7 )"

pkg_setup() {
	DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README* TODO"
	# Do not enable network tests in an ebuild environment
	G2CONF="${G2CONF} --disable-network-tests"
}

src_prepare() {
	# Do not leak main context reference, from master
	epatch "${FILESDIR}/${PN}-2.0.8-context-leak.patch"

	# Fix usage of check framework, bug #296849, from master
	epatch "${FILESDIR}/${PN}-2.0.8-check-usage-update.patch"

	# ifdef around network tests code, refs. bug #320759
	epatch "${FILESDIR}/${PN}-2.0.8-network-tests.patch"

	# Do not pass silly cflags with USE=debug, bug #320759
	sed -i \
		-e 's:-Werror::' \
		-e '/AM_PROG_CC_STDC/d' \
		-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:g' \
		configure.ac || die

	eautoreconf
	gnome2_src_prepare
}

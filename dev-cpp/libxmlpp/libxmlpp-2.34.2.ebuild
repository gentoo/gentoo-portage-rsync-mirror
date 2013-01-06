# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-2.34.2.ebuild,v 1.7 2012/05/04 03:44:56 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_ORG_MODULE="${PN/pp/++}"

inherit gnome2

DESCRIPTION="C++ wrapper for the libxml2 XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND=">=dev-libs/libxml2-2.6.1
	>=dev-cpp/glibmm-2.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable doc documentation)"
	DOCS="AUTHORS ChangeLog NEWS README*"
}

src_prepare() {
	gnome2_src_prepare

	# don't waste time building the examples
	sed 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' \
		-i Makefile.am Makefile.in || die "sed Makefile.in failed"
}

src_install() {
	gnome2_src_install

	rm -fr "${ED}"usr/share/doc/libxml++*
	use doc && dohtml docs/reference/html/*
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libskk/libskk-0.0.11.ebuild,v 1.3 2012/07/08 18:24:24 naota Exp $

EAPI=4

inherit virtualx

MY_VALA_VERSION=0.14

DESCRIPTION="GObject-based library to deal with Japanese kana-to-kanji conversion method"
HOMEPAGE="https://github.com/ueno/libskk"
SRC_URI="mirror://github/ueno/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls +introspection static-libs"

RDEPEND=">=dev-libs/glib-2.16
	dev-libs/libgee:0
	dev-libs/json-glib
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-lang/vala:${MY_VALA_VERSION}
	virtual/pkgconfig
	nls? (
		dev-util/intltool
		sys-devel/gettext
		)"
# doc? ( >=dev-util/valadoc-0.3.1 )

DOCS="ChangeLog NEWS README"

src_configure() {
	export VALAC="$(type -P valac-${MY_VALA_VERSION})"
	econf \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_enable introspection)
}

src_test() {
	Xemake check || die "emake check failed."
}

src_install() {
	default
	rm -f "${ED}"/usr/lib*/lib*.la
}

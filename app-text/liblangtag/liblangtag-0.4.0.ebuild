# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/liblangtag/liblangtag-0.4.0.ebuild,v 1.3 2012/12/01 12:57:10 scarabeus Exp $

EAPI=5

DESCRIPTION="An interface library to access tags for identifying languages"
HOMEPAGE="https://github.com/tagoh/liblangtag/"
SRC_URI="https://github.com/downloads/tagoh/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="introspection static-libs test"

RDEPEND="
	dev-libs/glib
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	test? ( dev-libs/check )
"

# Upstream expect liblangtag to be installed when one runs tests...
RESTRICT="test"

src_configure() {
	econf \
		$(use_enable introspection) \
		$(use_enable static-libs static) \
		$(use_enable test)
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}

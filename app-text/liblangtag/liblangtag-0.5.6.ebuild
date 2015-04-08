# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/liblangtag/liblangtag-0.5.6.ebuild,v 1.1 2015/04/04 23:49:28 dilfridge Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="An interface library to access tags for identifying languages"
HOMEPAGE="http://tagoh.bitbucket.org/liblangtag/"
SRC_URI="https://bitbucket.org/tagoh/${PN}/downloads/${P}.tar.bz2"

LICENSE="|| ( LGPL-3 MPL-1.1 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="introspection static-libs test"

RDEPEND="
	dev-libs/glib
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )"
DEPEND="${RDEPEND}
	dev-libs/gobject-introspection-common
	sys-devel/gettext
	test? ( dev-libs/check )"

# Upstream expect liblangtag to be installed when one runs tests...
RESTRICT="test"

src_configure() {
	local myeconfargs=(
		$(use_enable introspection)
		$(use_enable test)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	prune_libtool_files --all
}

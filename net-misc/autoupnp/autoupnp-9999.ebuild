# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autoupnp/autoupnp-9999.ebuild,v 1.1 2012/12/15 12:44:30 mgorny Exp $

EAPI=4

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"

inherit git-2
#endif

inherit autotools-utils

DESCRIPTION="Automatic open port forwarder using UPnP"
HOMEPAGE="https://bitbucket.org/mgorny/autoupnp/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

RDEPEND="net-libs/miniupnpc
	libnotify? ( x11-libs/libtinynotify )"
DEPEND="${RDEPEND}"

#if LIVE
KEYWORDS=
SRC_URI=
#endif

src_configure() {
	myeconfargs=(
		$(use_with libnotify)
	)

	autotools-utils_src_configure
}

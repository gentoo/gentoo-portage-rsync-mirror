# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pe-format/pe-format-2.9999.ebuild,v 1.1 2012/12/15 12:55:53 mgorny Exp $

EAPI=4

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}2.git"

inherit git-2
#endif

inherit autotools-utils fdo-mime systemd

DESCRIPTION="Intelligent PE executable wrapper for binfmt_misc"
HOMEPAGE="https://bitbucket.org/mgorny/pe-format2/"
SRC_URI="mirror://bitbucket/mgorny/${PN}2/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="!<sys-apps/openrc-0.9.4"

#if LIVE
KEYWORDS=
SRC_URI=

DEPEND="sys-devel/systemd-sdk"
#endif

src_configure() {
	systemd_to_myeconfargs
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	keepdir /var/lib
}

pkg_postinst() {
	ebegin "Calling pe-format2-setup to update handler setup"
	pe-format2-setup
	eend ${?}

	fdo-mime_desktop_database_update
}

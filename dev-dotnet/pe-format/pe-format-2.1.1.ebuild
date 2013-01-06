# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pe-format/pe-format-2.1.1.ebuild,v 1.5 2012/08/31 09:02:13 mgorny Exp $

EAPI=4

inherit autotools-utils fdo-mime systemd

DESCRIPTION="Intelligent PE executable wrapper for binfmt_misc"
HOMEPAGE="https://bitbucket.org/mgorny/pe-format2/"
SRC_URI="mirror://bitbucket/mgorny/${PN}2/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="!<sys-apps/openrc-0.9.4"

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

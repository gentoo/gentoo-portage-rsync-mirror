# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/flyte-download-manager/flyte-download-manager-1.2.4.0.ebuild,v 1.1 2013/02/28 03:41:51 ford_prefect Exp $

EAPI=4

inherit eutils fdo-mime

MY_PN="FlyteDownloadManager"

DESCRIPTION="The Flipkart Download Manager for Flyte MP3s"
HOMEPAGE="http://www.flipkart.com/"
SRC_URI="amd64? ( http://downloadi.flipkart.com/fkdm/${PV}/${MY_PN}-amd64.deb )
	x86? ( http://downloadi.flipkart.com/fkdm/${PV}/${MY_PN}-i386.deb )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND=""
RDEPEND="${DEPEND}
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXext
	x11-libs/libX11"

S="${WORKDIR}"

src_install() {
	tar -zxv -C "${D}" -f data.tar.gz || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

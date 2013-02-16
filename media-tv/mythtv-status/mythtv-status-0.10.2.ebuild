# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv-status/mythtv-status-0.10.2.ebuild,v 1.1 2013/02/16 22:38:43 cardoe Exp $

EAPI=5

DESCRIPTION="Displays the current status of MythTV at the command prompt"
HOMEPAGE="http://www.etc.gen.nz/projects/mythtv/mythtv-status.html"
#SRC_URI="http://www.etc.gen.nz/projects/mythtv/tarballs/${P}.tar.gz"
SRC_URI="mirror://ubuntu/pool/universe/m/mythtv-status/mythtv-status_0.10.2.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/XML-LibXML
	dev-perl/DateManip
	dev-perl/MIME-tools
	dev-perl/Sys-SigAction
	dev-perl/Config-Auto
	media-tv/mythtv[perl]"
RDEPEND="${DEPEND}"

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	exeinto /usr/bin
	doexe bin/mythtv-status
	doman "${FILESDIR}/mythtv-status.1"
}

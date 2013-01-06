# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv-status/mythtv-status-0.10.1.ebuild,v 1.2 2012/06/24 00:15:31 cardoe Exp $

EAPI=4

DESCRIPTION="Displays the current status of MythTV at the command prompt"
HOMEPAGE="http://www.etc.gen.nz/projects/mythtv/mythtv-status.html"
SRC_URI="http://www.etc.gen.nz/projects/mythtv/tarballs/${P}.tar.gz"

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
}

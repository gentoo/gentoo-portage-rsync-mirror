# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/mr/mr-1.13.ebuild,v 1.1 2012/08/31 13:55:32 tove Exp $

EAPI=4

DESCRIPTION="Multiple Repository management tool"
HOMEPAGE="http://kitenet.net/~joey/code/mr/"
SRC_URI="mirror://debian/pool/main/m/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/libwww-perl
	dev-perl/HTML-Parser"

S=${WORKDIR}/${PN}

src_install() {
	dobin mr webcheckout
	doman mr.1 webcheckout.1
	dodoc README TODO debian/changelog \
		mrconfig mrconfig.complex
	insinto /usr/share/${PN}
	doins lib/*
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/mr/mr-1.14.ebuild,v 1.1 2013/03/10 08:38:12 tove Exp $

EAPI=5

DESCRIPTION="Multiple Repository management tool"
HOMEPAGE="http://joeyh.name/code/mr/"
SRC_URI="mirror://debian/pool/main/m/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
"

S=${WORKDIR}/${PN}

src_install() {
	dobin mr webcheckout
	doman mr.1 webcheckout.1
	dodoc README TODO debian/changelog \
		mrconfig mrconfig.complex
	insinto /usr/share/${PN}
	doins lib/*
}

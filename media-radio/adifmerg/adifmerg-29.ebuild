# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/adifmerg/adifmerg-29.ebuild,v 1.3 2011/01/11 15:22:16 phajdan.jr Exp $

MY_P=${P/-}

DESCRIPTION="A small conversion and check utility for ADIF files"
HOMEPAGE="http://jaakko.home.cern.ch/jaakko/Soft/"
SRC_URI="http://jaakko.home.cern.ch/jaakko/Soft/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

RDEPEND="dev-lang/perl"

S=${WORKDIR}/${MY_P}

src_install() {
	dobin adifmerg || die "dobin failed"
	doman doc/adifmerg.1 || die "doman failed"
	dodoc CHANGELOG README || die "dodoc failed"

	if use examples; then
		insinto /usr/share/${PN}
		doins -r script || die "doins failed"
	fi
}

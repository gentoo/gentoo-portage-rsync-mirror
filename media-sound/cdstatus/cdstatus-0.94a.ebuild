# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdstatus/cdstatus-0.94a.ebuild,v 1.16 2009/06/05 10:56:19 ssuominen Exp $

EAPI=2
inherit eutils

MY_P=${PN}${PV}

DESCRIPTION="Tool for diagnosing cdrom drive and digital data (audio) extraction"
HOMEPAGE="http://cdstatus.sourceforge.net/"
SRC_URI="mirror://sourceforge/cdstatus/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_install() {
	dobin cdstatus || die "dobin failed"
	fperms 755 /usr/bin/cdstatus
	dodoc docs/*
}

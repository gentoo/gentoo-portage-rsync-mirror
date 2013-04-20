# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/asr-manpages/asr-manpages-1.3_rc6.ebuild,v 1.8 2013/04/20 22:09:16 ulm Exp $

inherit eutils

MY_R="6"
MY_P="${PN}_${PV/_rc6/}"
DESCRIPTION="set of humorous manual pages developed on alt.sysadmin.recovery"
HOMEPAGE="http://debian.org/"
SRC_URI="mirror://debian/pool/main/a/asr-manpages/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/a/asr-manpages/${MY_P}-${MY_R}.diff.gz"

LICENSE="freedist" #465704
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/man"

S=${WORKDIR}/${MY_P/_/-}.orig

src_unpack() {
	unpack ${A}
	epatch "${MY_P}-${MY_R}.diff"
}

src_install() {
	rm -rf debian
	doman * || die
}

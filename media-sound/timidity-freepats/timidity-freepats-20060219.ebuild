# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-freepats/timidity-freepats-20060219.ebuild,v 1.13 2011/03/16 19:29:01 xarthisius Exp $

EAPI=2

MY_PN=${PN/timidity-/}

DESCRIPTION="Free and open set of instrument patches"
HOMEPAGE="http://freepats.opensrc.org/"
SRC_URI="${HOMEPAGE}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RESTRICT="binchecks strip"

RDEPEND=""
DEPEND=">=app-admin/eselect-timidity-20061203"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	echo "dir /usr/share/timidity/${MY_PN}" > timidity.cfg
	cat freepats.cfg >> timidity.cfg
}

src_install() {
	insinto /usr/share/timidity/${MY_PN}
	doins -r timidity.cfg Drum_000 Tone_000
	dodoc README
}

pkg_postinst() {
	eselect timidity update --global --if-unset
}

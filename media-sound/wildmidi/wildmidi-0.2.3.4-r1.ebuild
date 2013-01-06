# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wildmidi/wildmidi-0.2.3.4-r1.ebuild,v 1.12 2011/03/16 19:29:43 xarthisius Exp $

EAPI=3

inherit base autotools

DESCRIPTION="Midi processing library and a midi player using the gus patch set"
HOMEPAGE="http://wildmidi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 x86"
IUSE="alsa debug"

DEPEND="alsa? ( media-libs/alsa-lib )"
RDEPEND="${DEPEND}
	media-sound/timidity-freepats"

src_prepare() {
	#Respect LDFLAGS. Reported upstream. Bug id: 3045017
	sed -i -e "/^LDFLAGS/s:=:=\"${LDFLAGS}\":" configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-werror \
		$(use_enable debug) \
		$(use alsa || echo --with-oss)
}

src_install() {
	base_src_install
	find "${D}" -name '*.la' -exec rm -f {} +
	insinto /etc
	doins "${FILESDIR}"/${PN}.cfg || die
}

pkg_postinst() {
	elog "${PN} is using timidity-freepats for midi playback."
	elog "A default configuration file was placed on /etc/${PN}.cfg."
	elog "For more information please read the ${PN}.cfg manpage."
}

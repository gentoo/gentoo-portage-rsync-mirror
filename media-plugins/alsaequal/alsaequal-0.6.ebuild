# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsaequal/alsaequal-0.6.ebuild,v 1.3 2010/09/25 12:30:17 ssuominen Exp $

EAPI=2
inherit eutils multilib toolchain-funcs

DESCRIPTION="a real-time adjustable equalizer plugin for ALSA"
HOMEPAGE="http://www.thedigitalmachine.net/alsaequal.html"
SRC_URI="http://www.thedigitalmachine.net/tools/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	media-plugins/caps-plugins"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall -fPIC -DPIC" \
		LD="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS} -shared" \
		SND_PCM_LIBS="-lasound" \
		SND_CTL_LIBS="-lasound" || die
}

src_install() {
	exeinto /usr/$(get_libdir)/alsa-lib
	doexe *.so || die
	dodoc README || die
}

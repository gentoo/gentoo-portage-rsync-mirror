# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsaequal/alsaequal-0.6-r1.ebuild,v 1.1 2013/06/27 18:41:11 aballier Exp $

EAPI=5
inherit eutils multilib toolchain-funcs multilib-minimal

DESCRIPTION="a real-time adjustable equalizer plugin for ALSA"
HOMEPAGE="http://www.thedigitalmachine.net/alsaequal.html"
SRC_URI="http://www.thedigitalmachine.net/tools/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/alsa-lib[${MULTILIB_USEDEP}]
	media-plugins/caps-plugins[${MULTILIB_USEDEP}]
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r3
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}
DOCS=( README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	multilib_copy_sources
}

multilib_src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall -fPIC -DPIC" \
		LD="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS} -shared" \
		Q= \
		SND_PCM_LIBS="-lasound" \
		SND_CTL_LIBS="-lasound" || die
}

multilib_src_install() {
	exeinto /usr/$(get_libdir)/alsa-lib
	doexe *.so || die
}

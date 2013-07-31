# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-2.3.1-r1.ebuild,v 1.1 2013/07/31 17:35:07 aballier Exp $

EAPI=5
inherit eutils multilib-minimal

DESCRIPTION="library for connecting and sending data to icecast servers"
HOMEPAGE="http://www.icecast.org/"
SRC_URI="http://downloads.xiph.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="speex static-libs theora"

RDEPEND="media-libs/libogg[${MULTILIB_USEDEP}]
	media-libs/libvorbis[${MULTILIB_USEDEP}]
	speex? ( media-libs/speex[${MULTILIB_USEDEP}] )
	theora? ( media-libs/libtheora[${MULTILIB_USEDEP}] )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-medialibs-20130224-r6
		!app-emulation/emul-linux-x86-medialibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		$(use_enable theora) \
		$(use_enable speex)
}

multilib_src_install_all() {
	dodoc README examples/example.c
	rm -rf "${ED}"/usr/share/doc/${PN}
	prune_libtool_files
}

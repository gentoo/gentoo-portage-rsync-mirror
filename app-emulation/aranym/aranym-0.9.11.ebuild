# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/aranym/aranym-0.9.11.ebuild,v 1.1 2013/01/30 05:39:21 patrick Exp $

EAPI=5

inherit flag-o-matic eutils

DESCRIPTION="Atari Running on Any Machine, a VM running Atari ST/TT/Falcon OS and TOS/GEM applications"
HOMEPAGE="http://aranym.sourceforge.net/"
SRC_URI="mirror://sourceforge/aranym/${P}.tar.gz
	mirror://sourceforge/aranym/afros812.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="opengl"

RDEPEND="media-libs/libsdl[X]
	games-emulation/emutos
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_configure() {
	filter-flags -mpowerpc-gfxopt

	local myconf=""
	if [[ ${ARCH} == x86 ]]; then
		myconf="${myconf} --enable-jit-compiler"
	fi

	econf $(use_enable opengl) ${myconf}
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install || die "installation failed"

	insinto /usr/share/${PN}
	doins -r "${WORKDIR}"/afros || die

	dodoc "${D}"/usr/share/doc/${PN}/* || die
	rm -r "${D}"/usr/share/doc/${PN} || die
}

pkg_postinst() {
	elog "To run ARAnyM with AFROS type: aranym --config /usr/share/aranym/afros/config"
}

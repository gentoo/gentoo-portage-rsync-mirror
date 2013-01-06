# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/brutefir/brutefir-1.0i.ebuild,v 1.5 2012/06/09 02:08:39 zmedico Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="Software convolution engine for applying long FIR filters"
HOMEPAGE="http://www.ludd.luth.se/~torger/brutefir.html"
SRC_URI="http://www.ludd.luth.se/~torger/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	media-sound/jack-audio-connection-kit
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}"

src_install() {
	mkdir -p "${D}"/usr/bin
	mkdir -p "${D}"/usr/lib/brutefir

	einstall DESTDIR="${D}" INSTALL_PREFIX="${D}"/usr \
		|| die "einstall failed"

	if [ "$(get_libdir)" != "lib" ]; then
		mv "${D}"/usr/lib "${D}"/usr/$(get_libdir)
	fi

	dodoc CHANGES README

	insinto usr/share/brutefir
	doins xtc_config directpath.txt crosspath.txt massive_config \
		bench1_config bench2_config bench3_config bench4_config bench5_config
}

pkg_postinst() {
	elog "Brutefir is a complicated piece of software. Please"
	elog "read the documentation first! You can find"
	elog "documentation here: http://www.ludd.luth.se/~torger/brutefir.html"
	elog "Example config files are in /usr/share/brutefir"
}

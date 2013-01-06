# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/vmoconv/vmoconv-1.0.ebuild,v 1.6 2008/06/20 23:05:36 mrness Exp $

inherit eutils

DESCRIPTION="A tool that converts Siemens phones VMO and VMI audio files to gsm and wav."
HOMEPAGE="http://triq.net/obex/"
SRC_URI="http://triq.net/obexftp/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-glibc28.patch"
}

src_compile() {
	econf || die "configure failed"
	# ugly workaround, otherwise make tries to build binaries before
	# necessary .la file is built
	cd src && make libgsm.la || die "make libgsm failed"
	cd ..
	emake || die "make failed"
}

src_install() {
	dobin src/vmo2gsm src/gsm2vmo src/vmo2wav
	dodoc AUTHORS ChangeLog NEWS README THANKS
}

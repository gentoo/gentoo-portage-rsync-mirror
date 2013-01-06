# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.2.3-r1.ebuild,v 1.12 2012/05/04 03:33:14 jdhore Exp $

inherit eutils

DESCRIPTION="Tool for conversion of MSWord doc and rtf files to something readable"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"
HOMEPAGE="http://wvware.sourceforge.net/"

IUSE="wmf"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2
	>=gnome-extra/libgsf-1.13
	sys-libs/zlib
	media-libs/libpng
	dev-libs/libxml2
	wmf? ( >=media-libs/libwmf-0.2.2 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {

	econf `use_with wmf libwmf` || die "./configure failed"

	emake || die "Compilation failed"

}

src_install () {

	make DESTDIR="${D}" install || die "Installation failed"

	dodoc README

	rm -f "${D}"/usr/share/man/man1/wvConvert.1
	dosym  /usr/share/man/man1/wvWare.1 /usr/share/man/man1/wvConvert.1

}

pkg_postinst() {

	ewarn "You have to re-emerge packages that linked against wv by running:"
	ewarn "revdep-rebuild"

}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.2.9.ebuild,v 1.4 2012/06/04 04:08:31 zmedico Exp $

EAPI="3"

inherit eutils multilib

DESCRIPTION="Tool for conversion of MSWord doc and rtf files to something readable"
SRC_URI="http://abiword.org/downloads/${PN}/${PV}/${P}.tar.gz"
HOMEPAGE="http://wvware.sourceforge.net/"

IUSE="wmf"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2
	>=gnome-extra/libgsf-1.13
	sys-libs/zlib
	media-libs/libpng
	dev-libs/libxml2
	app-text/texlive-core
	dev-texlive/texlive-latex
	wmf? ( >=media-libs/libwmf-0.2.2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use_with wmf libwmf)
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libwv-1.2.so.3
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libwv-1.2.so.3
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc README NEWS || die

	rm -f "${ED}"/usr/share/man/man1/wvConvert.1
	dosym  /usr/share/man/man1/wvWare.1 /usr/share/man/man1/wvConvert.1 || die
}

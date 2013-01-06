# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv/wv-1.2.7.ebuild,v 1.2 2012/05/04 03:33:14 jdhore Exp $

EAPI=2

inherit eutils

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
	wmf? ( >=media-libs/libwmf-0.2.2 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# Workaround incorrect soname bump as fedora does
	sed -i 's/^LT_CURRENT=`expr $WV_MICRO_VERSION - $WV_INTERFACE_AGE`/LT_CURRENT=3/' configure \
	|| die
}

src_configure() {
	econf `use_with wmf libwmf` || die "./configure failed"
}

src_compile() {
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

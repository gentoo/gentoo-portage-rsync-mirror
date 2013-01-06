# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-qtpixmap/gtk-engines-qtpixmap-0.28-r2.ebuild,v 1.11 2012/05/05 04:10:06 jdhore Exp $

EAPI="1"

inherit autotools eutils

MY_P="QtPixmap-${PV}"

DESCRIPTION="A modified version of the original GTK pixmap engine which follows the KDE color scheme"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=7043"
SRC_URI="http://www.cpdrummond.freeuk.com/${MY_P}.tar.gz"

KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
LICENSE="GPL-2"
SLOT="0"

IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Add switches to enable/disable gtk1 and gtk2 engines in the configure
	# script.
	epatch "${FILESDIR}/${P}-gtk_switches.patch"
	sed -i \
		-e 's/AC_CHECK_COMPILERS/AC_PROG_CC/' \
		configure.in
	rm acinclude.m4
	eautoreconf
}

src_compile() {
	local myconf="--enable-gtk2 --disable-gtk1"

	econf $myconf || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog README
}

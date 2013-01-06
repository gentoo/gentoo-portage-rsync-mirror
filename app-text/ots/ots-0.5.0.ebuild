# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ots/ots-0.5.0.ebuild,v 1.11 2012/08/05 20:51:32 blueness Exp $

inherit eutils

DESCRIPTION="Open source Text Summarizer, as used in newer releases of abiword and kword."
HOMEPAGE="http://libots.sourceforge.net/"
SRC_URI="mirror://sourceforge/libots/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~mips ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="=dev-libs/glib-2*
	>=dev-libs/libxml2-2.4.23
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-math.patch
}

src_compile() {
	# bug 97448
	econf --disable-gtk-doc || die

	# ugly ugly hack, kick upstream to fix its packaging
	touch "${S}"/gtk-doc.make

	# parallel make fails, bug 112932
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -rf "${D}"/usr/share/doc/libots
	dodoc AUTHORS BUGS ChangeLog HACKING NEWS README TODO
	cd "${S}"/doc/html
	dohtml -r ./
}

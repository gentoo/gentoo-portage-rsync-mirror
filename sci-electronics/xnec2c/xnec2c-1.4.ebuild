# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/xnec2c/xnec2c-1.4.ebuild,v 1.5 2011/06/02 13:23:05 maekke Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="A GTK+ graphical interactive version of nec2c."
HOMEPAGE="http://5b4az.chronos.org.uk/pages/nec2.html"
SRC_URI="http://5b4az.chronos.org.uk/pkg/nec2/xnec2c/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

S="${WORKDIR}/${PN}"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fortify.patch

	glib-gettextize --force --copy || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS README doc/*.txt || die
	dohtml -r doc/* || die
	if use examples	; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/* || die
	fi
}

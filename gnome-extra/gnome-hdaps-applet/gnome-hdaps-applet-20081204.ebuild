# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-hdaps-applet/gnome-hdaps-applet-20081204.ebuild,v 1.4 2012/05/05 06:25:16 jdhore Exp $

EAPI=2

inherit eutils multilib toolchain-funcs

DESCRIPTION="Visualization of the Hard Disc Active Protection System State as Gnome applet"
HOMEPAGE="http://www.zen24593.zen.co.uk/hdaps/"
SRC_URI="http://www.zen24593.zen.co.uk/hdaps/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	x11-libs/gtk+:2"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	app-laptop/hdapsd"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-include-and-unused.patch
}

src_compile() {
	$(tc-getCC) -c -Wall ${CFLAGS} \
		$($(tc-getPKG_CONFIG) --cflags gtk+-2.0) \
		$($(tc-getPKG_CONFIG) --cflags libpanelapplet-2.0) \
		-o ${PN}.o ${PN}.c || die
	$(tc-getCC) -Wall ${LDFLAGS} -Wl,--as-needed \
		-o ${PN} ${PN}.o \
		$($(tc-getPKG_CONFIG) --libs-only-L gtk+-2.0) \
		$($(tc-getPKG_CONFIG) --libs-only-L libpanelapplet-2.0) \
		-lgtk-x11-2.0 -lpanel-applet-2 || die
}

src_install() {
	dobin ${PN} || die
	insinto /usr/share/pixmaps/${PN}
	doins hdaps-*.png || die
	insinto /usr/$(get_libdir)/bonobo/servers
	doins GNOME_HDAPS_StatusApplet.server || die
}

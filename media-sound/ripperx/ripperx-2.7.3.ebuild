# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ripperx/ripperx-2.7.3.ebuild,v 1.6 2012/05/05 08:49:23 mgorny Exp $

EAPI=2
inherit eutils

MY_P=${P/x/X}
MY_PN=${PN/x/X}

DESCRIPTION="a GTK program to rip CD audio tracks and encode them to the Ogg, MP3, or FLAC formats."
HOMEPAGE="http://sourceforge.net/projects/ripperx"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2
	media-sound/lame
	media-sound/cdparanoia
	media-libs/id3lib"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-pkgconfig.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc BUGS CHANGES FAQ README* TODO
	doicon src/xpms/${MY_PN}-icon.xpm
	make_desktop_entry ${MY_PN} ${MY_PN} ${MY_PN}-icon
}

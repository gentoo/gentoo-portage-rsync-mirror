# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/dvd95/dvd95-1.6_p0.ebuild,v 1.3 2012/12/02 16:19:53 sping Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="DVD95 is a Gnome application to convert DVD9 to DVD5."
HOMEPAGE="http://dvd95.sourceforge.net/"
SRC_URI="mirror://sourceforge/dvd95/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="3dnow nls mmx mpeg sse sse2"

RDEPEND=">=gnome-base/libgnomeui-2
	dev-libs/libxml2
	media-libs/libdvdread
	mpeg? ( media-libs/libmpeg2 )
	media-video/mplayer"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext
		dev-util/intltool )
	sys-apps/sed"

S=${WORKDIR}/${P/_}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.3_p2-desktop-entry.patch
	epatch "${FILESDIR}"/${P}-link-libxml2.patch
	sed -i -e "s:-O3:${CFLAGS}:" configure.in || die "sed failed"
	echo "dvd95.glade" >> po/POTFILES.in || die "translation fix failed"
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable mpeg libmpeg2)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
}

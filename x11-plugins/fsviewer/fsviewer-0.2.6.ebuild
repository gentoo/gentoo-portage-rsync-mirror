# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/fsviewer/fsviewer-0.2.6.ebuild,v 1.2 2012/07/11 22:06:05 voyageur Exp $

EAPI=4
inherit autotools eutils multilib

MY_P=${PN}-app-${PV}

DESCRIPTION="A file system viewer for Window Maker"
HOMEPAGE="http://www.bayernline.de/~gscholz/linux/fsviewer/"
SRC_URI="http://www.bayernline.de/~gscholz/linux/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=x11-wm/windowmaker-0.95.2
	x11-libs/libXft
	x11-libs/libXpm
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-wmaker-0.95_support.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		--with-appspath=/usr/$(get_libdir)/GNUstep
}

src_install() {
	emake DESTDIR="${D}" install
	dosym /usr/$(get_libdir)/GNUstep/FSViewer.app/FSViewer /usr/bin/FSViewer
	dodoc AUTHORS ChangeLog NEWS README
}

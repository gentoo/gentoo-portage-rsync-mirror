# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gtk-recordmydesktop/gtk-recordmydesktop-0.3.8-r1.ebuild,v 1.4 2011/03/12 13:05:20 tomka Exp $

EAPI=3

inherit eutils

DESCRIPTION="GTK interface for RecordMyDesktop"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
# Test is buggy : bug #186752
# Tries to run intl-toolupdate without it being substituted from
# configure, make test tries run make check in flumotion/test what
# makes me think that this file has been copied from flumotion without
# much care...
RESTRICT=test

RDEPEND=">=x11-libs/gtk+-2.10.0:2
	dev-python/pygtk:2
	>=media-video/recordmydesktop-0.3.5
	x11-apps/xwininfo"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-check-for-jack.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README AUTHORS ChangeLog
}

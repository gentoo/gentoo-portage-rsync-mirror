# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kim4/kim4-0.9.5.ebuild,v 1.5 2014/01/05 21:34:47 creffett Exp $

EAPI=5

inherit eutils

DESCRIPTION="A Dolphin and Konqueror service menu for ImageMagick"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Kim+%28Kde+Image+Menu%29?content=11505"
SRC_URI="http://bouveyron.free.fr/kim/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

RDEPEND="
	kde-base/kdialog
	|| (
		kde-base/dolphin
		kde-base/konqueror
	)
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.sh.patch
}

src_install() {
	DESTDIR=${D} ./install.sh || die
	dodoc AUTHORS ChangeLog README || die
}

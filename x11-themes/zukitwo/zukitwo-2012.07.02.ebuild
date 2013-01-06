# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/zukitwo/zukitwo-2012.07.02.ebuild,v 1.4 2012/10/04 15:07:46 ago Exp $

EAPI="4"

DESCRIPTION="Theme for GNOME 2 and 3"
HOMEPAGE="http://gnome-look.org/content/show.php/Zukitwo?content=140562"
# Upstream download URI updates file contents without changing the filename
SRC_URI="http://dev.gentoo.org/~tetromino/distfiles/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=x11-libs/gtk+-3.4:3
	>=x11-themes/gtk-engines-murrine-0.98.1.1
	>=x11-themes/gtk-engines-unico-1.0.2"
DEPEND="app-arch/xz-utils"

# INSTALL file contains useful information for the end user
DOCS=( INSTALL README )

src_prepare() {
	# Gentoo uses normal nautilus, not nautilus-elementary
	sed -e 's:apps/nautilus-e.rc:apps/nautilus.rc:' \
		-i Zukitwo{,-Dark}/gtk-2.0/gtkrc || die
}

src_install() {
	insinto /usr/share/themes
	doins -r Zukitwo Zukitwo-Dark
	insinto /usr/share/themes/Zukitwo
	doins panelbg.png
	default
}

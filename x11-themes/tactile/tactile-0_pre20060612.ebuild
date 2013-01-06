# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tactile/tactile-0_pre20060612.ebuild,v 1.1 2011/06/24 19:34:58 hwoarang Exp $

EAPI=4

MY_PN="Tactile"

DESCRIPTION="Nice, calm and dark low contrast GTK+ theme."
HOMEPAGE="http://gnome-look.org/content/show.php/Tactile?content=40771"
SRC_URI="http://gnome-look.org/CONTENT/content-files/40771-${MY_PN}.tar.gz"

LICENSE="CCPL-Attribution-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto /usr/share/themes
	doins -r "${S}"/
}

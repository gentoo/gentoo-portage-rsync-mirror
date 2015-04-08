# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvola/nuvola-1.0-r1.ebuild,v 1.13 2009/10/14 17:15:03 ssuominen Exp $

DESCRIPTION="Nuvola SVG icon theme"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5358"
SRC_URI="http://www.icon-king.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RESTRICT="strip binchecks"

DEPEND="!=kde-base/kdeartwork-iconthemes-4*"

S=${WORKDIR}

src_install() {
	cd nuvola
	dodoc thanks.to readme.txt author
	rm thanks.to thanks.to~ readme.txt author license.txt

	cd "${S}"
	insinto /usr/share/icons
	doins -r nuvola
}

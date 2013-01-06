# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculator/qalculator-0.4b.ebuild,v 1.2 2012/02/17 13:47:36 pesa Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="A Qt4 based small calculator application"
HOMEPAGE="http://www.qt-apps.org/content/show.php/Qalculator?content=101326"
SRC_URI="http://www.qt-apps.org/CONTENT/content-files/101326-${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${P}-src

src_install() {
	dobin Qalculator
	make_desktop_entry Qalculator Qalculator accessories-calculator
}

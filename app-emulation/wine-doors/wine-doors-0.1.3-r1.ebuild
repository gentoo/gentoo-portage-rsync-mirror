# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine-doors/wine-doors-0.1.3-r1.ebuild,v 1.1 2014/12/26 23:09:13 mgorny Exp $

EAPI=5

DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Wine-doors is a package manager for wine"
HOMEPAGE="http://www.wine-doors.org"
SRC_URI="http://www.wine-doors.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/librsvg-python[${PYTHON_USEDEP}]
	gnome-base/libglade
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	app-pda/orange
	app-arch/cabextract
	app-emulation/wine"
RDEPEND="${DEPEND}
	dev-python/gconf-python[${PYTHON_USEDEP}]"

python_compile() { :; }

python_install() {
	local -x USER='root'
	distutils-r1_python_install --temp="${D}"

	keepdir /etc/wine-doors
	python_optimize "${D}"usr/share/wine-doors/src
}

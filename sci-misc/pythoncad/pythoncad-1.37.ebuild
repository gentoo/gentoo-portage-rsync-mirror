# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/pythoncad/pythoncad-1.37.ebuild,v 1.3 2011/03/02 21:23:21 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils versionator

MY_PN="PythonCAD"
MY_PV="DS$(get_major_version)-R$(get_after_major_version)"
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="CAD program written in PyGTK"
HOMEPAGE="http://www.pythoncad.org/"
SRC_URI="mirror://sourceforge/pythoncad/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygtk:2"
DEPEND=""

PYTHON_MODNAME=${MY_PN}

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-png.patch"

	sed -i \
		-e "s/gtkpycad.png/pythoncad.png/" \
		-e "s/gtkpycad.py/pythoncad/" \
		"pythoncad.desktop" || die "sed failed"
}

src_install() {
	distutils_src_install

	install_pythoncad() {
		newbin gtkpycad.py pythoncad-${PYTHON_ABI}
	}
	python_execute_function -q install_pythoncad
	python_generate_wrapper_scripts "${ED}usr/bin/pythoncad"

	insinto /etc/"${PN}"
	doins prefs.py
	domenu pythoncad.desktop
	insinto /usr/share/pixmaps
	newins gtkpycad.png pythoncad.png
}

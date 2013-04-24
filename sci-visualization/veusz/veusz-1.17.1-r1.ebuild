# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/veusz/veusz-1.17.1-r1.ebuild,v 1.1 2013/04/24 23:01:02 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit  eutils fdo-mime distutils-r1

DESCRIPTION="Qt scientific plotting package with good Postscript output"
HOMEPAGE="http://home.gna.org/veusz/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

IUSE="doc fits"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/PyQt4[X,svg,${PYTHON_USEDEP}]
	fits? ( virtual/pyfits[${PYTHON_USEDEP}] )"

python_install() {
	distutils-r1_python_install
	einfo "${D}/$(python_get_sitedir)/${PN}/COPYING"
	# symlink the license, bug #341653
	ln -s "${PORTDIR}"/licenses/${LICENSE} \
		"${D}/$(python_get_sitedir)"/${PN}/COPYING || die
}

python_install_all() {
	use doc && dodoc Documents/manual.pdf && \
		dohtml -r Documents/{manimages,manual.html}

	newicon windows/icons/veusz_48.png veusz.png
	domenu "${FILESDIR}"/veusz.desktop
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/veusz.xml
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

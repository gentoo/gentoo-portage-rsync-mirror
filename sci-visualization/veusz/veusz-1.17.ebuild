# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/veusz/veusz-1.17.ebuild,v 1.1 2013/03/28 13:43:46 grozin Exp $

EAPI=4

# python cruft
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"
PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

inherit distutils eutils fdo-mime

DESCRIPTION="Qt based scientific plotting package with good Postscript output"
HOMEPAGE="http://home.gna.org/veusz/ http://pypi.python.org/pypi/veusz"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

IUSE="doc examples fits"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}
	dev-python/PyQt4[X,svg]
	fits? ( dev-python/pyfits )"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
	use doc && dodoc Documents/manual.pdf && \
		dohtml -r Documents/{manimages,manual.html}

	newicon windows/icons/veusz_48.png veusz.png
	domenu "${FILESDIR}"/veusz.desktop
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/veusz.xml
	# symlinking the license, bug #341653
	symlink_license() {
		dosym /usr/portage/licenses/GPL-2 "$(python_get_sitedir)/${PN}"/COPYING
	}
	python_execute_function -q symlink_license
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
}

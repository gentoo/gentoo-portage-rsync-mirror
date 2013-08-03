# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyosd/pyosd-0.2.14.ebuild,v 1.12 2013/08/03 09:45:50 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="PyOSD is a python module for displaying text on your X display, much like the 'On Screen Displays' used on TVs and some monitors."
HOMEPAGE="http://ichi2.net/pyosd/"
SRC_URI="http://ichi2.net/pyosd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86"
IUSE="examples"

DEPEND=">=x11-libs/xosd-2.2.4"
RDEPEND="${DEPEND}"

DOCS="AUTHORS"

src_install() {
	distutils_src_install

	dohtml pyosd.html

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r modules || die "doins failed"
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "If you want to run the included daemon, you will need to install dev-python/twisted-core."
	elog "Also note that the volume plugin requires media-sound/aumix."
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/kedpm/kedpm-0.4.0-r1.ebuild,v 1.3 2011/04/06 17:59:12 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="Ked Password Manager helps to manage large amounts of passwords and related information"
HOMEPAGE="http://kedpm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="gtk"

DEPEND="dev-python/pycrypto
	gtk? ( >=dev-python/pygtk-2 )"
RDEPEND="${DEPEND}"

DOCS="AUTHORS CHANGES NEWS"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# We want documentation to install in /usr/share/doc/kedpm
	# not in /usr/share/kedpm as in original setup.py.
	epatch "${FILESDIR}/setup-doc.patch"

	# If we don't compiling with GTK support, let's change default
	# frontend for kedpm to CLI.
	use gtk || sed -i -e 's/"gtk"  # default/"cli"  # default/' scripts/kedpm
}

src_test() {
	PYTHONPATH="build/lib" "$(PYTHON)" run_tests || die "Tests failed"
}

src_install() {
	distutils_src_install

	# menu item
	domenu "${FILESDIR}/${PN}.desktop"
}

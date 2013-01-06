# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hachoir-metadata/hachoir-metadata-1.3.3.ebuild,v 1.1 2010/10/16 20:29:18 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Program to extract metadata using Hachoir library"
HOMEPAGE="http://bitbucket.org/haypo/hachoir/wiki/hachoir-metadata http://pypi.python.org/pypi/hachoir-metadata"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnome gtk kde qt4"

RDEPEND=">=dev-python/hachoir-core-1.3
	>=dev-python/hachoir-parser-1.3
	gtk? ( >=dev-python/pygtk-2.0 )
	gnome? ( gnome-base/nautilus gnome-extra/zenity )
	kde? ( kde-base/konqueror )
	qt4? ( dev-python/PyQt4 )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DISTUTILS_GLOBAL_OPTIONS=("--setuptools")
PYTHON_MODNAME="${PN/-/_}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_doc.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use gnome; then
		exeinto /usr/share/nautilus-scripts
		doexe gnome/hachoir
	fi

	if use kde; then
		exeinto /usr/bin
		doexe kde/hachoir-metadata-kde
		insinto /usr/share/apps/konqueror/servicemenus
		doins kde/hachoir.desktop
	fi

	if ! use gtk; then
		rm "${ED}usr/bin/hachoir-metadata-gtk"*
	fi

	if ! use qt4; then
		rm "${ED}usr/bin/hachoir-metadata-qt"*
	fi
}

pkg_postinst() {
	distutils_pkg_postinst

	if use gnome; then
		elog "To enable the nautilus script, symlink it with:"
		elog " $ mkdir -p ~/.gnome2/nautilus-scripts"
		elog " $ ln -s /usr/share/nautilus-scripts/hachoir ~/.gnome2/nautilus-script"
	fi
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/eyeD3/eyeD3-0.6.18-r1.ebuild,v 1.8 2014/08/21 12:41:50 armin76 Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RESTRICT_PYTHON_ABIS="2.4 3.*"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_configure() {
	python_execute_function -d -f -q
}

src_install() {
	dohtml *.html && rm -f *.html
	distutils_src_install

	install_script() {
		mkdir -p "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
		cp bin/eyeD3 "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
	}
	python_execute_function -q install_script
	python_merge_intermediate_installation_images "${T}/images"

	doman doc/*.1

	# Use the eyeD3 binary from SLOT="0.7"
	rm -rf "${ED}"/usr/bin
}

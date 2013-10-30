# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snakeoil/snakeoil-0.5.2.ebuild,v 1.3 2013/10/30 19:21:36 mgorny Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

PYTHON_ABI="2.5 2.6 2.7 3.1 3.2"
inherit distutils

DESCRIPTION="Miscellaneous python utility code."
HOMEPAGE="http://snakeoil.googlecode.com/"
SRC_URI="http://snakeoil.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DOCS="AUTHORS NEWS"

RDEPEND="!dev-lang/python-exec:2"

pkg_setup() {
	# disable snakeoil 2to3 caching
	unset PY2TO3_CACHEDIR
	python_pkg_setup

	# A hack to install for all versions of Python in the system.
	# pkgcore needs it to support upgrading to a different Python slot.
	PYTHON_ABIS=""
	local python_interpreter
	for python_interpreter in /usr/bin/python{2.[4-9],3.[1-9]}; do
		if [[ -x "${python_interpreter}" ]]; then
			PYTHON_ABIS+=" ${python_interpreter#/usr/bin/python}"
		fi
	done
	export PYTHON_ABIS="${PYTHON_ABIS# }"
}

src_test() {
	testing() {
		local tempdir
		tempdir="${T}/tests/python-${PYTHON_ABI}"
		mkdir -p "${tempdir}" || die "tempdir creation failed"
		cp -r "${S}" "${tempdir}" || die "test copy failed"
		cd "${tempdir}/${P}"
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snakeoil/snakeoil-9999.ebuild,v 1.3 2012/10/18 12:18:50 ferringb Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

PYTHON_ABI="2.5 2.6 2.7 3.1 3.2"
EGIT_REPO_URI="https://code.google.com/p/snakeoil/"
inherit distutils git-2

DESCRIPTION="Miscellaneous python utility code."
HOMEPAGE="http://snakeoil.googlecode.com/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="!<sys-apps/pkgcore-0.4.7.8"
RDEPEND=${DEPEND}

DOCS="AUTHORS NEWS"

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

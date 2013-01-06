# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/empy/empy-3.3.ebuild,v 1.13 2010/03/28 17:31:31 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A powerful and robust templating system for Python"
HOMEPAGE="http://www.alcyone.com/software/empy/"
SRC_URI="http://www.alcyone.com/software/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="em.py"

src_prepare() {
	distutils_src_prepare
	sed -e "s:/usr/local/bin/python:/usr/bin/python:g" -i em.py || die "sed failed"
}

src_test() {
	testing() {
		./test.sh "$(PYTHON)"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	dodir /usr/bin

	create_symlink() {
		python_convert_shebangs $(python_get_version) "${ED}$(python_get_sitedir)/em.py"
		fperms 755 "$(python_get_sitedir)/em.py"
		dosym "$(python_get_sitedir)/em.py" "/usr/bin/em.py-${PYTHON_ABI}"
	}
	python_execute_function -q create_symlink

	python_generate_wrapper_scripts "${ED}usr/bin/em.py"

	if use doc; then
		dodir /usr/share/doc/"${PF}"/examples
		insinto /usr/share/doc/"${PF}"/examples
		doins sample.em sample.bench
		#3.3 has the html in this funny place. Fix in later version:
		dohtml doc/home/max/projects/empy/doc/em/*
		dohtml doc/home/max/projects/empy/doc/em.html
		dohtml doc/index.html
	fi
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrex/pyrex-0.9.9.ebuild,v 1.8 2012/12/02 06:06:23 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="Pyrex-${PV}"

DESCRIPTION="A language for writing Python extension modules"
HOMEPAGE="http://www.cosc.canterbury.ac.nz/greg.ewing/python/Pyrex/"
SRC_URI="http://www.cosc.canterbury.ac.nz/greg.ewing/python/Pyrex/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="examples"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="Pyrex"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt ToDo.txt USAGE.txt"

src_install() {
	distutils_src_install

	dohtml -A c -r Doc/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r Demos
	fi
}

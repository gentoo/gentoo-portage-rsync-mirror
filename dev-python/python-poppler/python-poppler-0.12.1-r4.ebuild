# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler/python-poppler-0.12.1-r4.ebuild,v 1.3 2013/03/17 17:06:03 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools-utils eutils python-r1

DESCRIPTION="Python bindings to the Poppler PDF library"
HOMEPAGE="http://launchpad.net/poppler-python"
SRC_URI="http://launchpad.net/poppler-python/trunk/development/+download/pypoppler-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="examples"

S=${WORKDIR}/pypoppler-${PV}

RDEPEND="${PYTHON_DEPS}
	>=app-text/poppler-0.15.0:=[cairo]
	>=dev-python/pycairo-1.8.4[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

# http://pkgs.fedoraproject.org/gitweb/?p=pypoppler.git;a=tree
PATCHES=(
	"${FILESDIR}"/${P}-75_74.diff
	"${FILESDIR}"/${P}-79_78.diff
	"${FILESDIR}"/${P}-poppler0.15.0-changes.patch
	"${FILESDIR}"/${P}-poppler-0.18.0-minimal-fix.patch
)

src_configure() {
	python_parallel_foreach_impl autotools-utils_src_configure
}

src_compile() {
	python_foreach_impl autotools-utils_src_compile
}

src_test() {
	python_foreach_impl autotools-utils_src_test
}

src_install() {
	python_foreach_impl autotools-utils_src_install
	prune_libtool_files --modules

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}/examples
		doins demo/demo-poppler.py
	fi
}

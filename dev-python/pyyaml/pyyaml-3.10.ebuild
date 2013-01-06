# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyyaml/pyyaml-3.10.ebuild,v 1.6 2012/07/01 15:53:42 hattya Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="PyYAML-${PV}"

DESCRIPTION="YAML parser and emitter for Python"
HOMEPAGE="http://pyyaml.org/wiki/PyYAML http://pypi.python.org/pypi/PyYAML"
SRC_URI="http://pyyaml.org/download/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="examples libyaml"

DEPEND="libyaml? ( dev-libs/libyaml dev-python/pyrex )"
RDEPEND="libyaml? ( dev-libs/libyaml )"
RESTRICT_PYTHON_ABIS="2.4"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="yaml"

pkg_setup() {
	DISTUTILS_GLOBAL_OPTIONS=($(use_with libyaml))
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/.
	fi
}

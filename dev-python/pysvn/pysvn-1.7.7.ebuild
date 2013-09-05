# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysvn/pysvn-1.7.7.ebuild,v 1.3 2013/09/05 18:46:31 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2} )

inherit eutils distutils-r1 toolchain-funcs

DESCRIPTION="Object-oriented python bindings for subversion"
HOMEPAGE="http://pysvn.tigris.org/"
SRC_URI="http://pysvn.barrys-emacs.org/source_kits/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="doc examples"

DEPEND="
	>=dev-python/pycxx-6.2.0
	<dev-vcs/subversion-1.8"  # (bug #395533)
RDEPEND="${DEPEND}"
# Currently fail, no facility to add new issue upstream
RESTRICT="test"

python_prepare() {
	# Don't use internal copy of dev-python/pycxx.
	rm -fr Import

	epatch "${FILESDIR}"/${PN}-1.7.7-respect_flags.patch

	# http://pysvn.tigris.org/source/browse/pysvn?view=rev&revision=1469
	sed -e "s/PYSVN_HAS_SVN_CLIENT_CTX_T__CONFLICT_FUNC_16/PYSVN_HAS_SVN_CLIENT_CTX_T__CONFLICT_FUNC_1_6/" -i Source/pysvn_svnenv.hpp

	pushd Source > /dev/null
	if [[ "${EPYTHON:6:3}" == "2.5" ]]; then
		"${PYTHON}" setup.py backport || die "Backport failed"
	fi
}

python_configure() {
	cd Source
	# all config options from 1.7.6 are all already set
	"${PYTHON}" setup.py configure
}

python_compile() {
	cd Source
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)"
}

python_test() {
	cd Tests
	LC_ALL="en_US.UTF-8" emake
}

python_install() {
	cd Source/pysvn
	exeinto "$(python_get_sitedir)"/pysvn
	doexe _pysvn*$(get_modname)
	insinto "$(python_get_sitedir)"/pysvn
	doins __init__.py
}

python_install_all() {
	use doc && dohtml -r Docs/

	if use examples; then
		docinto examples
		dodoc Examples/Client/*
	fi
}

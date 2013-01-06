# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysvn/pysvn-1.7.6.ebuild,v 1.8 2013/01/05 12:07:53 ago Exp $

EAPI=4
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit eutils python toolchain-funcs

DESCRIPTION="Object-oriented python bindings for subversion"
HOMEPAGE="http://pysvn.tigris.org/"
SRC_URI="http://pysvn.barrys-emacs.org/source_kits/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="doc examples"

DEPEND="
	>=dev-python/pycxx-6.2.0
	<dev-vcs/subversion-1.8"  # (bug #395533)
RDEPEND="${DEPEND}"

src_prepare() {
	# Don't use internal copy of dev-python/pycxx.
	rm -fr Import

	epatch "${FILESDIR}/${P}-respect_flags.patch"

	# http://pysvn.tigris.org/source/browse/pysvn?view=rev&revision=1469
	sed -e "s/PYSVN_HAS_SVN_CLIENT_CTX_T__CONFLICT_FUNC_16/PYSVN_HAS_SVN_CLIENT_CTX_T__CONFLICT_FUNC_1_6/" -i Source/pysvn_svnenv.hpp

	python_copy_sources

	preparation() {
		cd Source
		if [[ "$(python_get_version -l)" == "2.5" ]]; then
			"$(PYTHON)" setup.py backport || die "Backport failed"
		fi
	}
	python_execute_function -s preparation
}

src_configure() {
	configuration() {
		cd Source
		"$(PYTHON)" setup.py configure \
			--pycxx-src-dir="${EPREFIX}/usr/share/python$(python_get_version)/CXX" \
			--apr-inc-dir="${EPREFIX}/usr/include/apr-1" \
			--apu-inc-dir="${EPREFIX}/usr/include/apr-1" \
			--svn-root-dir="${EPREFIX}/usr"
	}
	python_execute_function -s configuration
}

src_compile() {
	building() {
		cd Source
		emake CC="$(tc-getCC)" CXX="$(tc-getCXX)"
	}
	python_execute_function -s building
}

src_test() {
	testing() {
		cd Tests
		LC_ALL="en_US.UTF-8" emake
	}
	python_execute_function -s testing
}

src_install() {
	installation() {
		cd Source/pysvn
		exeinto "$(python_get_sitedir)/pysvn"
		doexe _pysvn*$(get_modname)
		insinto "$(python_get_sitedir)/pysvn"
		doins __init__.py
	}
	python_execute_function -s installation

	if use doc; then
		dohtml -r Docs/
	fi

	if use examples; then
		docinto examples
		dodoc Examples/Client/*
	fi
}

pkg_postinst() {
	python_mod_optimize pysvn
}

pkg_postrm() {
	python_mod_cleanup pysvn
}

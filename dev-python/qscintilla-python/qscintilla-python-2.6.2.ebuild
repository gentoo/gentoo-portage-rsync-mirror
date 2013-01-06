# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla-python/qscintilla-python-2.6.2.ebuild,v 1.6 2012/09/09 15:53:55 armin76 Exp $

EAPI=4
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-*"

inherit eutils python toolchain-funcs

MY_P=QScintilla-gpl-${PV}

DESCRIPTION="Python bindings for Qscintilla"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
SRC_URI="http://www.riverbankcomputing.co.uk/static/Downloads/QScintilla2/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="debug"

DEPEND="
	>=dev-python/sip-4.12
	>=dev-python/PyQt4-4.8[X]
	~x11-libs/qscintilla-${PV}
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}/Python

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.5.1-disable_stripping.patch"

	python_src_prepare
}

src_configure() {
	configuration() {
		local myconf=(
			"$(PYTHON)"
			configure.py
			-p 4
			--destdir="${EPREFIX}$(python_get_sitedir)/PyQt4"
			$(use debug && echo --debug)
		)
		echo "${myconf[@]}"
		"${myconf[@]}"
	}
	python_execute_function -s configuration
}

src_compile() {
	building() {
		emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)"
	}
	python_execute_function -s building
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qscintilla-python/qscintilla-python-2.7.2.ebuild,v 1.8 2013/09/05 19:25:04 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit eutils multilib python-r1 toolchain-funcs

MY_P=QScintilla-gpl-${PV}

DESCRIPTION="Python bindings for Qscintilla"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/qscintilla/intro"
SRC_URI="mirror://sourceforge/pyqt/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 ~sparc x86"
IUSE="debug"

DEPEND="
	${PYTHON_DEPS}
	>=dev-python/sip-4.12:=[${PYTHON_USEDEP}]
	>=dev-python/PyQt4-4.8[X,${PYTHON_USEDEP}]
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	~x11-libs/qscintilla-${PV}:=
"
RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S=${WORKDIR}/${MY_P}/Python

src_prepare() {
	python_copy_sources
}

src_configure() {
	configuration() {
		local myconf=(
			"${PYTHON}" configure-old.py
			--apidir="${EPREFIX}"/usr/share/qt4/qsci
			--destdir="$(python_get_sitedir)"/PyQt4
			--sipdir="${EPREFIX}"/usr/share/sip
			-n "${EPREFIX}"/usr/include/qt4
			-o "${EPREFIX}"/usr/$(get_libdir)/qt4
			-p 4
			--no-timestamp
			$(use debug && echo --debug)
		)
		echo "${myconf[@]}"
		"${myconf[@]}" || die
	}
	python_parallel_foreach_impl run_in_build_dir configuration
}

src_compile() {
	compilation() {
		emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" LINK="$(tc-getCXX)"
	}
	python_foreach_impl run_in_build_dir compilation
}

src_install() {
	python_foreach_impl run_in_build_dir default
}

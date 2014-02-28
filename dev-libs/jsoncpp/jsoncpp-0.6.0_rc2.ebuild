# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/jsoncpp/jsoncpp-0.6.0_rc2.ebuild,v 1.1 2014/02/28 00:17:19 vapier Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit toolchain-funcs python-any-r1

MY_P="${PN}-src-${PV/_/-}"

DESCRIPTION="C++ JSON reader and writer"
HOMEPAGE="http://jsoncpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc"

DEPEND="
	doc? (
		app-doc/doxygen
		${PYTHON_DEPS}
	)"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use doc && python-any-r1_pkg_setup
}

cxx_wrapper() {
	set -- $(tc-getCXX) ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} "$@"
	echo "$@"
	"$@"
}

src_compile() {
	# This is the soname that other distros use.
	local soname="libjsoncpp.so.0"

	cxx_wrapper src/lib_json/*.cpp -Iinclude -shared -fPIC \
		-Wl,-soname,${soname} -o libjsoncpp.so.${PV%_*} || die
	ln -sf libjsoncpp.so.${PV%_*} ${soname} || die
	ln -sf ${soname} libjsoncpp.so || die
}

src_install() {
	# Follow Debian, Ubuntu, Arch convention for headers location, bug #452234 .
	insinto /usr/include/jsoncpp
	doins -r include/json

	dolib.so libjsoncpp.so*

	if use doc; then
		${EPYTHON} doxybuild.py --doxygen=/usr/bin/doxygen || die
		dohtml dist/doxygen/jsoncpp*/*
	fi
}

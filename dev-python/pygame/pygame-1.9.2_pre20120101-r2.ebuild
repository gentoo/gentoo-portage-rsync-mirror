# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.9.2_pre20120101-r2.ebuild,v 1.4 2013/05/16 13:21:31 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2,3_3} )
DISTUTILS_IN_SOURCE_BUILD=1
inherit flag-o-matic distutils-r1 virtualx

DESCRIPTION="Python bindings for SDL multimedia library"
HOMEPAGE="http://www.pygame.org/"
if [[ "${PV}" == *_pre* ]]; then
	SRC_URI="http://people.apache.org/~Arfrever/gentoo/${P}.tar.xz"
else
	SRC_URI="http://www.pygame.org/ftp/pygame-${PV}release.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~sparc x86 ~x86-fbsd"
IUSE="doc examples X"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	>=media-libs/sdl-image-1.2.2[png,jpeg]
	>=media-libs/sdl-mixer-1.2.4
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/smpeg-0.4.4-r1
	X? ( >=media-libs/libsdl-1.2.5[X,video] )
	!X? ( >=media-libs/libsdl-1.2.5 )"
RDEPEND="${DEPEND}"

if [[ "${PV}" != *_pre* ]]; then
	S="${WORKDIR}/${P}release"
fi

DOCS=( WHATSNEW )

python_configure() {
	"${EPYTHON}" config.py -auto

	if ! use X; then
		sed -e "s:^scrap :#&:" -i Setup || die "sed failed"
	fi

	# Disable automagic dependency on PortMidi.
	sed -e "s:^pypm :#&:" -i Setup || die "sed failed"

	sed -i -e "s/import _camera/from pygame &/g" lib/camera.py || die #415593
}

python_compile() {
	if [[ ${EPYTHON} == python2* ]]; then
		local CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS}

		append-flags -fno-strict-aliasing
	fi

	distutils-r1_python_compile
}

python_test() {
	VIRTUALX_COMMAND="${PYTHON}" virtualmake run_tests.py
}

python_install() {
	distutils-r1_python_install

	rm -fr "${D}$(python_get_sitedir)/pygame/examples"
	rm -fr "${D}$(python_get_sitedir)/pygame/tests"
}

python_install_all() {
	distutils-r1_python_install_all

	if use doc; then
		dohtml -r docs/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}

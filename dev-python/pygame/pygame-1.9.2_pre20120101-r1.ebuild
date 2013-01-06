# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.9.2_pre20120101-r1.ebuild,v 1.7 2013/01/01 19:29:29 hasufell Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-**"
PYTHON_TESTS_RESTRICTED_ABIS="3.1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*"

inherit distutils virtualx

DESCRIPTION="Python bindings for SDL multimedia library"
HOMEPAGE="http://www.pygame.org/"
if [[ "${PV}" == *_pre* ]]; then
	SRC_URI="http://people.apache.org/~Arfrever/gentoo/${P}.tar.xz"
else
	SRC_URI="http://www.pygame.org/ftp/pygame-${PV}release.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc sparc x86 ~x86-fbsd"
IUSE="doc examples X"

DEPEND="dev-python/numpy
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

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="WHATSNEW"

src_configure() {
	"$(PYTHON -f)" config.py -auto

	if ! use X; then
		sed -e "s:^scrap :#&:" -i Setup || die "sed failed"
	fi

	# Disable automagic dependency on PortMidi.
	sed -e "s:^pypm :#&:" -i Setup || die "sed failed"

	sed -i -e "s/import _camera/from pygame &/g" lib/camera.py || die #415593
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" run_tests.py
	}
	VIRTUALX_COMMAND="python_execute_function" virtualmake testing
}

src_install() {
	distutils_src_install

	delete_examples_and_tests() {
		rm -fr "${ED}$(python_get_sitedir)/pygame/examples"
		rm -fr "${ED}$(python_get_sitedir)/pygame/tests"
	}
	python_execute_function -q delete_examples_and_tests

	if use doc; then
		dohtml -r docs/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}

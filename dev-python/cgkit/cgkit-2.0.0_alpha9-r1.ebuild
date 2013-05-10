# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgkit/cgkit-2.0.0_alpha9-r1.ebuild,v 1.5 2013/05/10 04:31:45 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

MY_P="${P/_/}"

DESCRIPTION="Python library for creating 3D images"
HOMEPAGE="http://cgkit.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

RDEPEND=">=dev-libs/boost-1.48[python]
	dev-python/pyprotocols
	dev-python/pyopengl
	dev-python/pygame
	dev-python/imaging
	3ds? ( media-libs/lib3ds )"
DEPEND="${RDEPEND}
	dev-util/scons"

LICENSE="LGPL-2.1 MPL-1.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="3ds"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	sed -e "s/fPIC/fPIC\",\"${CFLAGS// /\",\"}/" -i supportlib/SConstruct
	cp config_template.cfg config.cfg
	echo "BOOST_LIB = 'boost_python-${PYTHON_ABI}'" >> config.cfg
	echo "LIBS += ['GL', 'GLU', 'glut']" >> config.cfg
	if use 3ds; then
		echo "LIB3DS_AVAILABLE = True" >> config.cfg
	fi

	sed -e "s:INC_DIRS = \[\]:INC_DIRS = \['/usr/include'\]:" -i setup.py

	sed -e "160s/as/as_/;168s/as/as_/" -i cgkit/flockofbirds.py

	# Remove invalid test
	rm -f unittests/test_pointcloud.py || die
	epatch "${FILESDIR}"/${PN}-2.0.0-test.patch
}

src_compile() {
	pushd supportlib > /dev/null
	scons ${MAKEOPTS}
	popd > /dev/null

	distutils_src_compile
}

src_test() {
	cd unittests
	# Remove failing tests due to non-existing files
	rm test_maimport.py test_mayaascii.py test_mayabinary.py test_ri.py test_slparams.py
	PYTHONPATH="$(ls -d ../build/lib*)" "$(PYTHON)" all.py || die "Tests failed"
}

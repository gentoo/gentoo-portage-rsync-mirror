# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/wspr/wspr-3.01.ebuild,v 1.1 2014/06/26 09:15:52 tomjbe Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="tk"

inherit autotools fortran-2 distutils-r1 flag-o-matic multilib toolchain-funcs

MY_P=${P}.r2792

DESCRIPTION="Weak Signal Propagation Reporter"
HOMEPAGE="http://www.physics.princeton.edu/pulsar/K1JT/wspr.html"
SRC_URI="http://dev.gentoo.org/~tomjbe/distfiles/${MY_P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/python-imaging[tk,${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	virtual/pmw[${PYTHON_USEDEP}]
	sci-libs/fftw:3.0
	media-libs/hamlib
	media-libs/portaudio
	media-libs/libsamplerate"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS=( BUGS WSPR_Announcement.TXT WSPR0_Instructions.TXT WSPR_Quick_Start.TXT )

pkg_setup() {
	fortran-2_pkg_setup
}

get_fcomp() {
	case $(tc-getFC) in
	*gfortran* )	FCOMP="gfortran" ;;
	* ) 			FCOMP=$(tc-getFC) ;;
	esac
}

python_prepare_all() {
	tc-export FC
	get_fcomp
	export FC="${FCOMP}"

	local PATCHES=(
		"${FILESDIR}"/${PN}-2.00-libdir.patch
		"${FILESDIR}"/${P}-verbose.patch
		"${FILESDIR}"/${PN}-3.01-script.patch
		"${FILESDIR}"/${P}-PIL.patch
	)

	distutils-r1_python_prepare_all

	sed -i -e "s/LDFLAGS} ${LIBS}/LDFLAGS} -fPIC ${LIBS}/" Makefile.in || die
	sed -i -e "s#/usr/local/lib#/usr/$(get_libdir)#" configure.ac || die
	sed -i -e '/makedirs/d' setup.py || die
	eautoreconf
}

# Note: very hacky build system.
# autoconf which doesn't really need Python
# then custom Makefile which compiles the Python module with f2py
# and finally hacked setup.py which relies on w.so created by make

src_configure() {
	# configure the build of the fortran module
	econf --with-portaudio-lib-dir=/usr/$(get_libdir)

	# then fork the sources
	python_copy_sources
	DISTUTILS_IN_SOURCE_BUILD=1
}

python_compile() {
	# -shared is neded by f2py but cannot be set earlier as configure does
	# not like it
	local LDFLAGS=${LDFLAGS}
	append-ldflags -shared
	emake -j1
}

python_install_all() {
	distutils-r1_python_install_all

	dobin wspr
	insinto /usr/share/${PN}
	doins hamlib_rig_numbers
}

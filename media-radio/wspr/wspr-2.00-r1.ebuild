# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/wspr/wspr-2.00-r1.ebuild,v 1.1 2013/02/07 14:35:20 tomjbe Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="tk"

inherit autotools fortran-2 distutils-r1 flag-o-matic multilib toolchain-funcs

MY_P=${P}.r1714

DESCRIPTION="Weak Signal Propagation Reporter"
HOMEPAGE="http://www.physics.princeton.edu/pulsar/K1JT/wspr.html"
SRC_URI="http://www.physics.princeton.edu/pulsar/K1JT/${MY_P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/imaging[tk,${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	virtual/pmw[${PYTHON_USEDEP}]
	sci-libs/fftw:3.0
	media-libs/hamlib
	media-libs/portaudio
	media-libs/libsamplerate"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${P}-libdir.patch
	"${FILESDIR}"/${P}-verbose.patch
	"${FILESDIR}"/${P}-script.patch
	)

DOCS=( BUGS WSPR_Announcement.TXT WSPR_Instructions.TXT WSPR_Quick_Start.TXT )

DISTUTILS_IN_SOURCE_BUILD=1

pkg_setup() {
	fortran-2_pkg_setup
}

get_fcomp() {
	case $(tc-getFC) in
	*gfortran* )	FCOMP="gfortran" ;;
	* ) 			FCOMP=$(tc-getFC) ;;
	esac
}

python_prepare() {
	sed -i -e "s#/usr/local/lib#/usr/$(get_libdir)#" configure.ac || die
	eautoreconf
}

src_prepare() {
	tc-export FC
	get_fcomp
	export FC="${FCOMP}"

	distutils-r1_python_prepare_all
	python_foreach_impl run_in_build_dir python_prepare
}

python_configure() {
	# configure the built of the fortran module
	econf
}

python_compile() {
	# -shared is neded by f2py but cannot be set earlier as configure does
	# not like it
	append-ldflags -shared
	emake
}

src_install() {
	doit() {
		rm -rf build || die
		distutils-r1_python_install
	}

	python_foreach_impl run_in_build_dir doit
	distutils-r1_python_install_all

	dobin wspr
	insinto /usr/share/${PN}
	doins hamlib_rig_numbers
}

run_in_build_dir() {
	pushd "${BUILD_DIR}" > /dev/null || die
	"$@"
	popd > /dev/null
}

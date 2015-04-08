# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/vmd/vmd-1.9.1-r3.ebuild,v 1.1 2014/08/21 12:18:02 jlec Exp $

EAPI=5

PYTHON_DEPEND="2"

inherit cuda eutils multilib prefix python toolchain-funcs

DESCRIPTION="Visual Molecular Dynamics"
HOMEPAGE="http://www.ks.uiuc.edu/Research/vmd/"
SRC_URI="
	http://dev.gentoo.org/~jlec/distifles/${P}-gentoo-patches-2.tar.xz
	${P}.src.tar.gz"

SLOT="0"
LICENSE="vmd"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cuda msms povray tachyon xinerama"

RESTRICT="fetch"

# currently, tk-8.5* with USE=truetype breaks some
# tk apps such as Sequence Viewer or Timeline.
CDEPEND="
	|| ( =dev-lang/tk-8.5*:0=[-truetype] >=dev-lang/tk-8.6.1 )
	dev-lang/perl
	dev-python/numpy
	sci-libs/netcdf
	virtual/opengl
	>=x11-libs/fltk-1.1.10-r2:1
	x11-libs/libXft
	x11-libs/libXi
	cuda? ( >=dev-util/nvidia-cuda-toolkit-4.2.9-r1 )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${CDEPEND}
	dev-lang/swig"
RDEPEND="${CDEPEND}
	sci-biology/stride
	sci-chemistry/surf
	x11-terms/xterm
	msms? ( sci-chemistry/msms-bin )
	povray? ( media-gfx/povray )
	tachyon? ( media-gfx/tachyon )"

VMD_DOWNLOAD="http://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD"
# Binary only plugin!!
QA_PREBUILT="usr/lib*/vmd/plugins/LINUX/tcl/intersurf1.1/bin/intersurf.so"
QA_FLAGS_IGNORED_amd64=" usr/lib64/vmd/plugins/LINUX/tcl/volutil1.3/volutil"
QA_FLAGS_IGNORED_x86=" usr/lib/vmd/plugins/LINUX/tcl/volutil1.3/volutil"

pkg_nofetch() {
	elog "Please download ${P}.src.tar.gz from"
	elog "${VMD_DOWNLOAD}"
	elog "after agreeing to the license and get"
	elog "http://dev.gentoo.org/~jlec/distfiles/${P}-gentoo-patches-2.tar.xz"
	elog "Place both in ${DISTDIR}"
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	use cuda && cuda_sanitize

	epatch "${FILESDIR}"/${P}-cuda-device_ptr.patch

	cd "${WORKDIR}"/plugins

	epatch \
		"${WORKDIR}"/${P}-gentoo-plugins.patch \
		"${FILESDIR}"/${P}-tcl8.6.patch

	[[ ${SILENT} == yes ]] || sed '/^.SILENT/d' -i $(find -name Makefile)

	sed \
		-e "s:CC = gcc:CC = $(tc-getCC):" \
		-e "s:CXX = g++:CXX = $(tc-getCXX):" \
		-e "s:COPTO =.*\":COPTO = -fPIC -o\":" \
		-e "s:LOPTO = .*\":LOPTO = ${LDFLAGS} -fPIC -o\":" \
		-e "s:CCFLAGS =.*\":CCFLAGS = ${CFLAGS}\":" \
		-e "s:CXXFLAGS =.*\":CXXFLAGS = ${CXXFLAGS}\":" \
		-e "s:SHLD = gcc:SHLD = $(tc-getCC) -shared:" \
		-e "s:SHXXLD = g++:SHXXLD = $(tc-getCXX) -shared:" \
		-e "s:-ltcl8.5:-ltcl:" \
		-i Make-arch || die "Failed to set up plugins Makefile"

	sed \
		-e '/^AR /s:=:?=:g' \
		-e '/^RANLIB /s:=:?=:g' \
		-i ../plugins/*/Makefile || die

	tc-export AR RANLIB

	sed \
		-e "s:\$(CXXFLAGS)::g" \
		-i hesstrans/Makefile || die

	# prepare vmd itself
	cd "${S}"

	epatch "${WORKDIR}"/${P}-gentoo-base.patch

	# PREFIX
	sed \
		-e "s:/usr/include/:${EPREFIX}/usr/include:g" \
		-i configure || die

	sed \
		-e "s:gentoo-bindir:${ED}/usr/bin:g" \
		-e "s:gentoo-libdir:${ED}/usr/$(get_libdir):g" \
		-e "s:gentoo-opengl-include:${EPREFIX}/usr/include/GL:g" \
		-e "s:gentoo-opengl-libs:${EPREFIX}/usr/$(get_libdir):g" \
		-e "s:gentoo-gcc:$(tc-getCC):g" \
		-e "s:gentoo-g++:$(tc-getCXX):g" \
		-e "s:gentoo-nvcc:${EPREFIX}/opt/cuda/bin/nvcc:g" \
		-e "s:gentoo-cflags:${CFLAGS}:g" \
		-e "s:gentoo-cxxflags:${CXXFLAGS}:g" \
		-e "s:gentoo-nvflags::g" \
		-e "s:gentoo-ldflags:${LDFLAGS}:g" \
		-e "s:gentoo-plugindir:${WORKDIR}/plugins:g" \
		-e "s:gentoo-fltk-include:$(fltk-config --includedir):g" \
		-e "s:gentoo-fltk-libs:$(dirname $(fltk-config --libs)) -Wl,-rpath,$(dirname $(fltk-config --libs)):g" \
		-e "s:gentoo-netcdf-include:${EPREFIX}/usr/include:g" \
		-e "s:gentoo-netcdf-libs:${EPREFIX}/usr/$(get_libdir):g" \
		-i configure || die

#	local NUMPY_INCLUDE="numpy/core/include"
#	sed -e "s:gentoo-python-include:${EPREFIX}$(python_get_includedir):" \
#		-e "s:gentoo-python-lib:${EPREFIX}$(python_get_libdir):" \
#		-e "s:gentoo-python-link:$(PYTHON):" \
#		-e "s:gentoo-numpy-include:${EPREFIX}$(python_get_sitedir)/${NUMPY_INCLUDE}:" \
#		-i configure || die "failed setting up python"

	if use cuda; then
		sed \
			-e "s:gentoo-cuda-lib:${EPREFIX}/opt/cuda/$(get_libdir):g" \
			-e "/NVCCFLAGS/s:=:= ${NVCCFLAGS}:g" \
			-i configure src/Makefile || die
		sed \
			-e '/compute_/d' \
			-i configure || die
		sed \
			-e 's:-gencode .*code=sm_..::' \
			-i src/Makefile || die
	fi

	sed \
		-e "s:LINUXPPC:LINUX:g" \
		-e "s:LINUXALPHA:LINUX:g" \
		-e "s:LINUXAMD64:LINUX:g" \
		-e "s:gentoo-stride:${EPREFIX}/usr/bin/stride:g" \
		-e "s:gentoo-surf:${EPREFIX}/usr/bin/surf:g" \
		-e "s:gentoo-tachyon:${EPREFIX}/usr/bin/tachyon:g" \
		-i "${S}"/bin/vmd.sh || die "failed setting up vmd wrapper script"
}

src_configure() {
	local myconf="OPENGL FLTK TK TCL PTHREADS PYTHON IMD NETCDF NUMPY NOSILENT XINPUT"
	rm -f configure.options && echo $myconf >> configure.options

	use cuda && myconf+=" CUDA"
#	use mpi && myconf+=" MPI"
#	use tachion && myconf+=" LIBTACHYON"
	use xinerama && myconf+=" XINERAMA"

	export \
		PYTHON_INCLUDE_DIR="${EPREFIX}$(python_get_includedir)" \
		PYTHON_LIBRARY_DIR="${EPREFIX}$(python_get_libdir)" \
		PYTHON_LIBRARY="$(python_get_library -l)" \
		NUMPY_INCLUDE_DIR="${EPREFIX}$(python_get_sitedir)/numpy/core/include" \
		NUMPY_LIBRARY_DIR="${EPREFIX}$(python_get_sitedir)/numpy/core/include"

	./configure LINUX \
		${myconf} || die
}

src_compile() {
	# build plugins
	cd "${WORKDIR}"/plugins

	emake \
		TCLINC="-I${EPREFIX}/usr/include" \
		TCLLIB="-L${EPREFIX}/usr/$(get_libdir)" \
		NETCDFLIB="$(pkg-config --libs-only-L netcdf) ${EPREFIX}/usr/$(get_libdir)/libnetcdf.so" \
		NETCDFINC="$(pkg-config --cflags-only-I netcdf) ${EPREFIX}/usr/include" \
		NETCDFLDFLAGS="$(pkg-config --libs netcdf)" \
		LINUX

	# build vmd
	cd "${S}"/src
	emake
}

src_install() {
	# install plugins
	cd "${WORKDIR}"/plugins
	emake \
			PLUGINDIR="${ED}/usr/$(get_libdir)/${PN}/plugins" \
			distrib

	# install vmd
	cd "${S}"/src
	emake install

	# install docs
	cd "${S}"
	dodoc Announcement README doc/ig.pdf doc/ug.pdf

	# remove some of the things we don't want and need in
	# /usr/lib
	cd "${ED}"/usr/$(get_libdir)/vmd
	rm -fr doc README Announcement LICENSE || \
		die "failed to clean up /usr/lib/vmd directory"

	# adjust path in vmd wrapper
	sed \
		-e "s:${ED}::" -i "${ED}"/usr/bin/${PN} \
		-e "/^defaultvmddir/s:^.*$:defaultvmddir=\"${EPREFIX}/usr/$(get_libdir)/${PN}\":g" \
		|| die "failed to set up vmd wrapper script"

	# install icon and generate desktop entry
	insinto /usr/share/pixmaps
	doins "${WORKDIR}"/vmd.png
	eprefixify "${WORKDIR}"/vmd.desktop
	sed -i '/^Path/d' "${WORKDIR}"/vmd.desktop || die
	domenu "${WORKDIR}"/vmd.desktop
}

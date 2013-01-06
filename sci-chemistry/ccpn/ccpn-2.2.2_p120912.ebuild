# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ccpn/ccpn-2.2.2_p120912.ebuild,v 1.1 2012/09/12 11:26:07 jlec Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="ssl tk"

inherit eutils portability python toolchain-funcs versionator

PATCHSET="${PV##*_p}"
MY_PN="${PN}mr"
MY_PV="$(replace_version_separator 3 _ ${PV%%_p*})"
MY_MAJOR="$(get_version_component_range 1-3)"

DESCRIPTION="The Collaborative Computing Project for NMR"
SRC_URI="http://www-old.ccpn.ac.uk/download/${MY_PN}/analysis${MY_PV}.tar.gz"
	[[ -n ${PATCHSET} ]] && SRC_URI="${SRC_URI}	http://dev.gentoo.org/~jlec/distfiles/ccpn-update-${MY_MAJOR}-${PATCHSET}.patch.xz"
HOMEPAGE="http://www.ccpn.ac.uk/ccpn"

SLOT="0"
LICENSE="|| ( CCPN LGPL-2.1 )"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="extendnmr +opengl"

RDEPEND="
	dev-lang/tk[threads]
	dev-python/numpy
	dev-tcltk/tix
	=sci-libs/ccpn-data-"${MY_MAJOR}"*
	sci-biology/psipred
	x11-libs/libXext
	x11-libs/libX11
	opengl? (
		media-libs/freeglut
		dev-python/pyglet )"
# We need to fix this
#		sci-chemistry/mdd
DEPEND="${RDEPEND}"
PDEPEND="
	extendnmr? (
		>=sci-chemistry/aria-2.3.2-r1
		sci-chemistry/prodecomp )"

RESTRICT="mirror"

S="${WORKDIR}"/${MY_PN}/${MY_PN}$(get_version_component_range 1-2 ${PV})

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	[[ -n ${PATCHSET} ]] && \
		epatch "${WORKDIR}"/ccpn-update-${MY_MAJOR}-${PATCHSET}.patch

	epatch "${FILESDIR}"/${MY_PV}-parallel.patch

	sed \
		-e "/PSIPRED_DIR/s:'data':'share/psipred/data':g" \
		-e "s:weights_s:weights:g" \
		-i python/ccpnmr/analysis/wrappers/Psipred.py || die

	local tk_ver
	local myconf

	tk_ver="$(best_version dev-lang/tk | cut -d- -f3 | cut -d. -f1,2)"

	if use opengl; then
		GLUT_NEED_INIT="-DNEED_GLUT_INIT"
		IGNORE_GL_FLAG=""
		GL_FLAG="-DUSE_GL_TRUE"
		GL_DIR="${EPREFIX}/usr"
		GL_LIB="-lglut -lGLU -lGL"
		GL_INCLUDE_FLAGS="-I\$(GL_DIR)/include"
		GL_LIB_FLAGS="-L\$(GL_DIR)/$(get_libdir)"

	else
		IGNORE_GL_FLAG="-DIGNORE_GL"
		GL_FLAG="-DUSE_GL_FALSE"
	fi

	GLUT_NOT_IN_GL=""
	GLUT_FLAG="\$(GLUT_NEED_INIT) \$(GLUT_NOT_IN_GL)"

	rm -rf data model doc license || die

	sed \
		-e "s|/usr|${EPREFIX}/usr|g" \
		-e "s|^\(CC =\).*|\1 $(tc-getCC)|g" \
		-e "s|^\(OPT_FLAG =\).*|\1 ${CFLAGS}|g" \
		-e "s|^\(LINK_FLAGS =.*\)|\1 ${LDFLAGS}|g" \
		-e "s|^\(IGNORE_GL_FLAG =\).*|\1 ${IGNORE_GL_FLAG}|g" \
		-e "s|^\(GL_FLAG =\).*|\1 ${GL_FLAG}|g" \
		-e "s|^\(GL_DIR =\).*|\1 ${GL_DIR}|g" \
		-e "s|^\(GL_LIB =\).*|\1 ${GL_LIB}|g" \
		-e "s|^\(GL_LIB_FLAGS =\).*|\1 ${GL_LIB_FLAGS}|g" \
		-e "s|^\(GL_INCLUDE_FLAGS =\).*|\1 ${GL_INCLUDE_FLAGS}|g" \
		-e "s|^\(GLUT_NEED_INIT =\).*|\1 ${GLUT_NEED_INIT}|g" \
		-e "s|^\(GLUT_NOT_IN_GL =\).*|\1|g" \
		-e "s|^\(X11_LIB_FLAGS =\).*|\1 -L${EPREFIX}/usr/$(get_libdir)|g" \
		-e "s|^\(TCL_LIB_FLAGS =\).*|\1 -L${EPREFIX}/usr/$(get_libdir)|g" \
		-e "s|^\(TK_LIB_FLAGS =\).*|\1 -L${EPREFIX}/usr/$(get_libdir)|g" \
		-e "s|^\(PYTHON_INCLUDE_FLAGS =\).*|\1 -I${EPREFIX}/$(python_get_includedir)|g" \
		-e "s|^\(PYTHON_LIB =\).*|\1 $(python_get_library -l)|g" \
		c/environment_default.txt > c/environment.txt || die

	sed \
		-e 's:ln -s:cp -f:g' \
		-i $(find python -name linkSharedObjs) || die
}

src_compile() {
	emake -C c all
	emake -C c links
}

src_install() {
	local libdir
	local tkver
	local _wrapper

	find . -name "*.pyc" -type f -delete

	libdir=$(get_libdir)
	tkver=$(best_version dev-lang/tk | cut -d- -f3 | cut -d. -f1,2)

	_wrapper="analysis dangle dataShifter depositionFileImporter eci formatConverter pipe2azara xeasy2azara"
	use extendnmr && _wrapper="${_wrapper} extendNmr"
	for wrapper in ${_wrapper}; do
		sed \
			-e "s|gentoo_sitedir|${EPREFIX}$(python_get_sitedir)|g" \
		   -e "s|gentoolibdir|${EPREFIX}/usr/${libdir}|g" \
			-e "s|gentootk|${EPREFIX}/usr/${libdir}/tk${tkver}|g" \
			-e "s|gentootcl|${EPREFIX}/usr/${libdir}/tclk${tkver}|g" \
			-e "s|gentoopython|$(PYTHON -a)|g" \
			-e "s|gentoousr|${EPREFIX}/usr|g" \
			-e "s|//|/|g" \
			"${FILESDIR}"/${wrapper} > "${T}"/${wrapper} || die "Fail fix ${wrapper}"
		dobin "${T}"/${wrapper}
	done

	local in_path=$(python_get_sitedir)/${PN}
	local files
	local pydocs

	pydocs="$(find python -name doc -type d)"
	rm -rf ${pydocs} || die

	for i in python/memops/format/compatibility/{Converters,part2/Converters2}.py; do
	sed \
		-e 's|#from __future__|from __future__|g' \
		-i ${i} || die
	done

	insinto ${in_path}

	dodir ${in_path}/c

	ebegin "Installing main files"
		doins -r python
	eend

	ebegin "Adjusting permissions"

	for _file in $(find "${ED}" -type f -name "*so"); do
		chmod 755 ${_file}
	done
	eend
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}

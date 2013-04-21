# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pillow/pillow-2.0.0.ebuild,v 1.1 2013/04/21 20:17:26 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE='tk?'

inherit distutils-r1

MY_PN=Pillow
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python Imaging Library (PIL)"
HOMEPAGE="http://www.pythonware.com/products/pil/index.htm"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples jpeg lcms scanner test tiff tk truetype webp zlib"

RDEPEND="
	truetype? ( media-libs/freetype:2 )
	jpeg? ( virtual/jpeg )
	lcms? ( media-libs/lcms:0 )
	scanner? ( media-gfx/sane-backends )
	tiff? ( media-libs/tiff )
	webp? ( media-libs/libwebp )
	zlib? ( sys-libs/zlib )
	!dev-python/imaging"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )"

# Tests don't handle missing jpeg, tiff & zlib properly.
# https://github.com/python-imaging/Pillow/pull/199
REQUIRED_USE="test? ( jpeg tiff zlib )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Tests like to write to cwd.
	# https://github.com/python-imaging/Pillow/pull/200
	use test && DISTUTILS_IN_SOURCE_BUILD=1

	distutils-r1_src_prepare
}

python_prepare_all() {
	# Add shebangs.
	# https://github.com/python-imaging/Pillow/pull/197
	sed -e "1i#!/usr/bin/env python" -i Scripts/*.py || die

	# Disable all the stuff we don't want.
	local f
	for f in jpeg lcms tiff tk webp zlib; do
		if ! use ${f}; then
			sed -i -e "s:feature.${f} =:& None #:" setup.py || die
		fi
	done
	if ! use truetype; then
		sed -i -e 's:feature.freetype =:& None #:' setup.py || die
	fi

	distutils-r1_python_prepare_all
}

# XXX: split into two ebuilds?
wrap_phase() {
	"${@}"

	if use scanner; then
		cd Sane || die
		"${@}"
	fi
}

python_compile() {
	wrap_phase distutils-r1_python_compile
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	"${PYTHON}" selftest.py || die "Tests fail with ${EPYTHON}"
	"${PYTHON}" Tests/run.py --installed || die "Tests fail with ${EPYTHON}"
}

python_install() {
	python_doheader libImaging/{Imaging.h,ImPlatform.h}

	wrap_phase distutils-r1_python_install
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/. )
	use examples && local EXAMPLES=( Scripts/. )

	distutils-r1_python_install_all

	if use scanner; then
		docinto sane
		dodoc Sane/{CHANGES,README,sanedoc.txt}
	fi

	if use examples && use scanner; then
		docinto examples/sane
		doins Sane/demo_*.py
	fi
}

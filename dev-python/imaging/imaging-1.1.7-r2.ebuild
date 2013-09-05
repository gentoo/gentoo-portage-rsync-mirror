# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imaging/imaging-1.1.7-r2.ebuild,v 1.6 2013/09/05 18:46:38 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE='tk?'

inherit eutils multilib distutils-r1

MY_P=Imaging-${PV}

DESCRIPTION="Python Imaging Library (PIL)"
HOMEPAGE="http://www.pythonware.com/products/pil/index.htm"
SRC_URI="http://www.effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="doc examples lcms scanner tk X"

DEPEND="virtual/jpeg
	media-libs/freetype:2
	lcms? ( media-libs/lcms:0 )
	scanner? ( media-gfx/sane-backends )
	X? ( x11-misc/xdg-utils )"
RDEPEND="${DEPEND}"
RDEPEND+=" !dev-python/pillow"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${P}-no-xv.patch"
		"${FILESDIR}/${P}-sane.patch"
		"${FILESDIR}/${P}-giftrans.patch"
		"${FILESDIR}/${P}-missing-math.patch"
	)

	use lcms || PATCHES+=( "${FILESDIR}/${P}-nolcms.patch" )

	# Add shebang.
	sed -e "1i#!/usr/bin/python" -i Scripts/pilfont.py \
		|| die "sed	failed adding shebang"

	sed -i \
		-e "s:/usr/lib\":/usr/$(get_libdir)\":" \
		-e "s:\"lib\":\"$(get_libdir)\":g" \
		setup.py || die "sed failed"

	if ! use tk; then
		# Make the test always fail
		sed -i \
			-e 's/import _tkinter/raise ImportError/' \
			setup.py || die "sed failed"
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

python_test() {
	"${PYTHON}" selftest.py || die "Tests fail with ${EPYTHON}"
}

python_install() {
	local incdir=$(python_get_includedir)
	insinto "${incdir#${EPREFIX}}"
	doins libImaging/{Imaging.h,ImPlatform.h}

	wrap_phase distutils-r1_python_install
}

python_install_all() {
	use doc && local HTML_DOCS=( Docs/. )

	distutils-r1_python_install_all

	if use scanner; then
		docinto sane
		dodoc Sane/{CHANGES,README,sanedoc.txt}
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Scripts/.

		if use scanner; then
			insinto /usr/share/doc/${PF}/examples/sane
			doins Sane/demo_*.py
		fi
	fi
}

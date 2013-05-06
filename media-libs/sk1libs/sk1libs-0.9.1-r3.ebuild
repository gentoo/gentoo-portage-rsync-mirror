# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sk1libs/sk1libs-0.9.1-r3.ebuild,v 1.2 2013/05/06 09:42:47 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 python-r1

DESCRIPTION="sk1 vector graphics lib"
HOMEPAGE="http://sk1project.org"
SRC_URI="http://uniconvertor.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="
	media-fonts/ttf-bitstream-vera
	media-libs/freetype:2
	virtual/jpeg
	>=media-libs/lcms-1.15:0[python,${PYTHON_USEDEP}]
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	app-arch/bzip2
	app-arch/gzip
	app-text/ghostscript-gpl
	media-libs/netpbm
"

python_prepare_all() {
	sed \
		-e "/include_dirs/s:\(/usr/include/freetype2\):${EPREFIX}\1:" \
		-i setup.py || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	font-fixation() {
		local ttf
		local sitedir=$(python_get_sitedir)
		for ttf in "${ED}"/${sitedir#${EPREFIX}}/sk1libs/ft2engine/fallback_fonts/*.ttf; do
			rm -f "${ttf}" || die
			dosym \
				/usr/share/fonts/ttf-bitstream-vera/$(basename "${ttf}") \
				${sitedir#${EPREFIX}}/sk1libs/ft2engine/fallback_fonts/$(basename "${ttf}")
		done
	}
	python_foreach_impl font-fixation

	distutils-r1_python_install_all
}

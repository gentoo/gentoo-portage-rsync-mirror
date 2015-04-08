# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/uniconvertor/uniconvertor-1.1.5-r1.ebuild,v 1.4 2015/04/08 17:58:14 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Commandline tool for popular vector formats convertion"
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://uniconvertor.googlecode.com/files/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~x86-solaris"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE=""

DEPEND=">=media-libs/sk1libs-0.9.1[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-text/ghostscript-gpl"

PATCHES=( "${FILESDIR}/uniconvertor-1.1.5_export_raster.py_fix_import.patch" )

python_prepare_all() {
	sed -i \
		-e "s/'GNU_GPL_v2', 'GNU_LGPL_v2', 'COPYRIGHTS',//" \
		setup.py || die

	distutils-r1_python_prepare_all
}

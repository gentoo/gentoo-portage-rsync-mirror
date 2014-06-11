# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/nml/nml-0.3.1.ebuild,v 1.1 2014/06/11 15:17:53 mr_bones_ Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="Compiler of NML files into grf/nfo files"
HOMEPAGE="http://dev.openttdcoop.org/projects/nml"
SRC_URI="http://bundles.openttdcoop.org/nml/releases/${PV}/nml-0.3.1.r5242-f6a3ae1163ab.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"

RDEPEND="dev-python/pillow[zlib,${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${P}.r5242-f6a3ae1163ab

DOCS=( docs/{changelog,readme}.txt )

src_install() {
	distutils-r1_src_install
	doman docs/nmlc.1
}

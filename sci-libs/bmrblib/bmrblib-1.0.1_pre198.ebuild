# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/bmrblib/bmrblib-1.0.1_pre198.ebuild,v 1.3 2014/03/31 21:17:47 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="API abstracting the BioMagResBank (BMRB) NMR-STAR format (http://www.bmrb.wisc.edu/)"
HOMEPAGE="http://gna.org/projects/bmrblib/"
#SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

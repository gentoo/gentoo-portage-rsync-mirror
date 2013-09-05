# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/bmrblib/bmrblib-1.0.0-r1.ebuild,v 1.2 2013/09/05 19:04:43 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="API abstracting the BioMagResBank (BMRB) NMR-STAR format (http://www.bmrb.wisc.edu/)"
HOMEPAGE="http://gna.org/projects/bmrblib/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

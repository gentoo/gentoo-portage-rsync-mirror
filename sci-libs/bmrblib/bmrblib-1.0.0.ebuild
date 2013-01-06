# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/bmrblib/bmrblib-1.0.0.ebuild,v 1.2 2012/07/19 15:18:05 jlec Exp $

EAPI=4

PYTHON_DEPEND=*
SUPPORT_PYTHON_ABIS=1

inherit distutils

DESCRIPTION="API abstracting the BioMagResBank (BMRB) NMR-STAR format (http://www.bmrb.wisc.edu/)"
HOMEPAGE="http://gna.org/projects/bmrblib/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

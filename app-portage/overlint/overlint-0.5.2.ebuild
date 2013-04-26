# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/overlint/overlint-0.5.2.ebuild,v 1.2 2013/04/26 21:14:27 sping Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2} )

inherit distutils-r1

DESCRIPTION="Simple tool for static analysis of overlays"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/overlint.git;a=summary"
SRC_URI="http://www.hartwork.org/public/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/python-argparse"

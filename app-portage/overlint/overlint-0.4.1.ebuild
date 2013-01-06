# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/overlint/overlint-0.4.1.ebuild,v 1.2 2012/06/16 12:35:17 sping Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6 3"

inherit distutils

DESCRIPTION="Simple tool for static analysis of overlays"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/overlint.git;a=summary"
SRC_URI="http://www.hartwork.org/public/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( >=dev-lang/python-2.7
			( dev-libs/argtable >=dev-lang/python-2.6 ) )
	sys-apps/sed"

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-smbpasswd/py-smbpasswd-1.0.1.ebuild,v 1.6 2011/01/09 16:48:56 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="This module can generate both LANMAN and NT password hashes, suitable for use with Samba."
HOMEPAGE="http://barryp.org/software/py-smbpasswd/"
SRC_URI="http://barryp.org/software/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

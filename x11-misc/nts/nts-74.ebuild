# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/nts/nts-74.ebuild,v 1.1 2011/01/19 04:15:39 lack Exp $

EAPI=3
PYTHON_DEPEND="2:2.5"
inherit distutils

DESCRIPTION="Note Taking made Simple, an intuitive note taking application"
HOMEPAGE="http://www.duke.edu/~dgraham/NTS/"
SRC_URI="mirror://sourceforge/notetaking/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/wxpython:2.8
	dev-python/docutils"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="2.4 3.*"

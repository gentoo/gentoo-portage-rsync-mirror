# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py2play/py2play-0.1.10.ebuild,v 1.4 2012/06/03 02:50:54 xmw Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="${P/py2play/Py2Play}"

DESCRIPTION="A Peer To Peer network game engine"
HOMEPAGE="http://home.gna.org/oomadness/en/slune"
SRC_URI="http://download.gna.org/slune/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

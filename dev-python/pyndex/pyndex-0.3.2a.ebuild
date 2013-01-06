# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyndex/pyndex-0.3.2a.ebuild,v 1.10 2012/09/09 15:09:31 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="Pyndex"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Pyndex is a simple and fast full-text indexer (aka search engine) implemented in Python. It uses Metakit as its storage back-end."
HOMEPAGE="http://www.divmod.org/Pyndex/index.html"
SRC_URI="mirror://sourceforge/pyndex/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=dev-db/metakit-2.4.9.2[python]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

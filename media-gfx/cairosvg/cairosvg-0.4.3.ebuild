# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cairosvg/cairosvg-0.4.3.ebuild,v 1.1 2012/06/07 16:56:34 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 2.6 3.1"

inherit distutils

MY_PN=CairoSVG
MY_P=${MY_PN}-${PV}

DESCRIPTION="A simple cairo based SVG converter with support for PDF, PostScript and PNG formats"
HOMEPAGE="http://cairosvg.org/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/lxml
	dev-python/pycairo
	dev-python/tinycss"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="NEWS.rst README.rst TODO.rst"

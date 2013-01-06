# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subdl/subdl-1.0.3.ebuild,v 1.1 2010/11/02 21:15:32 ssuominen Exp $

EAPI=2
PYTHON_DEPEND="2:2.6"
inherit python

DESCRIPTION="A command-line tool for downloading subs from opensubtitles.org"
HOMEPAGE="http://code.google.com/p/subdl/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_prepare() {
	python_convert_shebangs 2 ${PN}
}

src_install() {
	dobin ${PN} || die
	dodoc README.txt
}

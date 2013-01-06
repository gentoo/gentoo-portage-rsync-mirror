# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freshmeat-submit/freshmeat-submit-2.2.ebuild,v 1.1 2011/01/06 21:15:32 jlec Exp $

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="A utility for submitting version updates to freshmeat.net, using freshmeat.net's XML-RPC interface"
HOMEPAGE="http://www.catb.org/~esr/freshmeat-submit/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs 2 ${PN}
}

src_compile() { :; }

src_install() {
	doman ${PN}.1 || die "doman failed"
	dodoc AUTHORS README || die "dodoc failed"
	dobin ${PN} || die "dobin failed"
}

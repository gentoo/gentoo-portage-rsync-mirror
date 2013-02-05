# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bakefile/bakefile-0.2.9.ebuild,v 1.1 2013/02/05 02:23:59 dirtyepic Exp $

EAPI=2

inherit base python bash-completion eutils

DESCRIPTION="Native makefiles generator"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bakefile.sourceforge.net"

LICENSE="MIT"

RDEPEND=""
DEPEND=""
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc"

src_install () {
	base_src_install

	dodoc AUTHORS NEWS README THANKS
	if use doc ; then
		dohtml -r doc/html/* || die "dodoc failed"
	fi

	dobashcompletion bash_completion bakefile
}

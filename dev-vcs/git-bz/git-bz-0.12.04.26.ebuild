# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-bz/git-bz-0.12.04.26.ebuild,v 1.1 2012/04/26 06:07:54 mgorny Exp $

EAPI=4
PYTHON_DEPEND=2

inherit python

DESCRIPTION="Bugzilla subcommand for git"
HOMEPAGE="http://www.fishsoup.net/software/git-bz/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git"

src_compile() {
	:
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc TODO
}

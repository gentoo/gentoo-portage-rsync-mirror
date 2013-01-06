# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-bz/git-bz-9999.ebuild,v 1.3 2012/12/17 19:30:00 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_8,1_9} )

inherit python-r1

#if LIVE
EGIT_REPO_URI="git://git.fishsoup.net/${PN}
	http://git.fishsoup.net/cgit/${PN}
	https://bitbucket.org/mgorny/${PN}.git"
inherit git-2
#endif

DESCRIPTION="Bugzilla subcommand for git"
HOMEPAGE="http://www.fishsoup.net/software/git-bz/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git"

#if LIVE
DEPEND="app-text/asciidoc
	app-text/xmlto"

KEYWORDS=
SRC_URI=

src_compile() {
	emake ${PN}.1
}
#endif

src_install() {
	python_foreach_impl python_doscript ${PN}
	doman ${PN}.1
	dodoc TODO
}

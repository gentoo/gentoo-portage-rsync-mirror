# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-bz/git-bz-0.12.12.15.ebuild,v 1.5 2013/09/05 18:42:26 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit python-r1

DESCRIPTION="Bugzilla subcommand for git"
HOMEPAGE="http://www.fishsoup.net/software/git-bz/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git"

src_install() {
	python_foreach_impl python_doscript ${PN}
	doman ${PN}.1
	dodoc TODO
}

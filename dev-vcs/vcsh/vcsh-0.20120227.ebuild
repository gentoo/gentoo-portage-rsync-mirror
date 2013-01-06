# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/vcsh/vcsh-0.20120227.ebuild,v 1.2 2012/04/22 11:54:05 tove Exp $

EAPI=4
GITHUB_ID=ffddb76

DESCRIPTION='Manage config files in $HOME via fake bare git repositories'
HOMEPAGE="https://github.com/RichiH/vcsh/blob/master/README.md"
SRC_URI="http://github.com/RichiH/vcsh/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git"
DEPEND="app-text/ronn"

S="${WORKDIR}/RichiH-vcsh-${GITHUB_ID}"
DOCS=( changelog )

src_prepare() {
	default
	sed -i \
		-e 's,vendor-completions,site-functions,' \
		-e "s,share/doc/\$(self),share/doc/${PF}," \
		Makefile || die
}

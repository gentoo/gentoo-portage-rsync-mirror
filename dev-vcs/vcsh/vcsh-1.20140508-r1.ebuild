# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/vcsh/vcsh-1.20140508-r1.ebuild,v 1.1 2014/09/09 15:10:40 dev-zero Exp $

EAPI=5

DESCRIPTION='Manage config files in $HOME via fake bare git repositories'
HOMEPAGE="https://github.com/RichiH/vcsh/"
SRC_URI="http://github.com/RichiH/vcsh/archive/v${PV}-1.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-vcs/git"
DEPEND="doc? ( app-text/ronn )"

S=${S}-1

src_compile() {
	use doc && emake manpages
}

src_install() {
	dobin vcsh

	dodoc -r changelog CONTRIBUTORS README.md doc/{hooks,sample_hooks}
	insinto /usr/share/zsh/site-functions
	doins _vcsh

	use doc && doman vcsh.1
}

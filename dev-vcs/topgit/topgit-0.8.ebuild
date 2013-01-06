# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/topgit/topgit-0.8.ebuild,v 1.3 2010/07/17 16:26:17 hwoarang Exp $

inherit bash-completion

DESCRIPTION="A different patch queue manager"
HOMEPAGE="http://repo.or.cz/w/topgit.git"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentooexperimental.org/~idl0r/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bash-completion"

DEPEND="sys-apps/sed
	sys-apps/gawk"
RDEPEND="dev-vcs/git"

src_compile() {
	# Needed because of "hardcoded" paths
	emake prefix="/usr" sharedir="/usr/share/doc/${PF}" || die
}

src_install() {
	emake prefix="${D}/usr" sharedir="${D}/usr/share/doc/${PF}" install || die

	if use bash-completion; then
		dobashcompletion contrib/tg-completion.bash ${PN}
	fi

	dodoc README || die
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/tig/tig-1.1.ebuild,v 1.1 2012/10/13 16:42:07 radhermit Exp $

EAPI=4

inherit bash-completion-r1

DESCRIPTION="Tig: text mode interface for git"
HOMEPAGE="http://jonas.nitro.dk/tig/"
SRC_URI="http://jonas.nitro.dk/tig/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-vcs/git"

src_install() {
	emake DESTDIR="${D}" install install-doc-man
	dodoc BUGS NEWS
	dohtml manual.html README.html
	newbashcomp contrib/tig-completion.bash ${PN}
}

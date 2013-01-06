# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-sh/eselect-sh-9999.ebuild,v 1.1 2012/12/15 12:37:16 mgorny Exp $

EAPI=4

inherit base
#if LIVE
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"
inherit git-2
#endif

DESCRIPTION="Manages the /bin/sh (POSIX shell) symlink"
HOMEPAGE="https://bitbucket.org/mgorny/eselect-sh/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

#if LIVE
KEYWORDS=
SRC_URI=
#endif

src_install() {
	insinto /usr/share/eselect/modules
	doins sh.eselect || die
}

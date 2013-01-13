# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-lib-bin-symlink/eselect-lib-bin-symlink-9999.ebuild,v 1.2 2013/01/13 14:30:00 mgorny Exp $

EAPI=5

#if LIVE
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"
AUTOTOOLS_AUTORECONF=1
inherit git-2
#endif

inherit autotools-utils

DESCRIPTION="An eselect library to manage executable symlinks"
HOMEPAGE="https://bitbucket.org/mgorny/eselect-lib-bin-symlink/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

#if LIVE
KEYWORDS=
SRC_URI=
#endif

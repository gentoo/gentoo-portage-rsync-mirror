# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/systemd-m4/systemd-m4-9999.ebuild,v 1.2 2013/10/16 13:24:42 mgorny Exp $

EAPI=5

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"

inherit git-r3
#endif

inherit autotools-utils

DESCRIPTION="autoconf macros for packages using systemd"
HOMEPAGE="https://bitbucket.org/mgorny/systemd-m4/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#if LIVE

KEYWORDS=
SRC_URI=
#endif

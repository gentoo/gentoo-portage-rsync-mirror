# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/systemd-sdk/systemd-sdk-9999.ebuild,v 1.1 2012/12/15 12:53:48 mgorny Exp $

EAPI=4

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"

inherit git-2
#endif

inherit autotools-utils

DESCRIPTION="Macros and misc files for systemd daemons"
HOMEPAGE="https://bitbucket.org/mgorny/systemd-sdk/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#if LIVE

KEYWORDS=
SRC_URI=
#endif

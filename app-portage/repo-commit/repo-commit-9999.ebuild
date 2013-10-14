# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/repo-commit/repo-commit-9999.ebuild,v 1.2 2013/10/14 20:38:55 mgorny Exp $

EAPI=5

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/gentoo/${PN}.git"

inherit git-r3
#endif

inherit autotools-utils

DESCRIPTION="A repository commit helper"
HOMEPAGE="https://bitbucket.org/gentoo/repo-commit/"
SRC_URI="mirror://bitbucket/gentoo/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	|| (
		>=sys-apps/portage-2.2.0_alpha86
		( >=sys-apps/portage-2.1.10.30
			<sys-apps/portage-2.2.0_alpha )
		app-portage/gentoolkit-dev
	)
	sys-apps/portage"
#if LIVE

KEYWORDS=
SRC_URI=
#endif

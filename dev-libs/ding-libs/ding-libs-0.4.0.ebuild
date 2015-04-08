# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ding-libs/ding-libs-0.4.0.ebuild,v 1.5 2015/03/06 06:54:05 jer Exp $

EAPI=5

inherit autotools-multilib

DESCRIPTION="Library set needed for build sssd"
HOMEPAGE="https://fedorahosted.org/sssd"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tar.gz"

LICENSE="LGPL-3 GPL-3"
SLOT="0"

KEYWORDS="amd64 ~arm ~hppa x86 ~amd64-linux"
IUSE="test static-libs"

RDEPEND=""

DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-libs/check )
	"

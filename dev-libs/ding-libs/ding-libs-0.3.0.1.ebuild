# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ding-libs/ding-libs-0.3.0.1.ebuild,v 1.3 2013/07/14 09:56:50 ago Exp $

EAPI=5

inherit autotools-multilib

DESCRIPTION="Library set needed for build sssd"
HOMEPAGE="https://fedorahosted.org/sssd"
SRC_URI="https://fedorahosted.org/released/${PN}/${P}.tar.gz"

LICENSE="LGPL-3 GPL-3"
SLOT="0"

KEYWORDS="amd64 x86 ~amd64-linux"
IUSE="test static-libs"

RDEPEND=""

DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( dev-libs/check )"

src_install() {
	autotools-utils_src_install
}

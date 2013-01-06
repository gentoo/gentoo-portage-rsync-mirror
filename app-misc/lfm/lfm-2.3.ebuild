# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/lfm/lfm-2.3.ebuild,v 1.1 2012/09/16 09:26:38 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="ncurses"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Last File Manager is a powerful file manager for the console"
HOMEPAGE="http://www.terra.es/personal7/inigoserna/lfm"
SRC_URI="http://www.terra.es/personal7/inigoserna/lfm/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-doc.patch
}

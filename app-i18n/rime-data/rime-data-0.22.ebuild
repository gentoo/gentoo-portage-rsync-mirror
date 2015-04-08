# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rime-data/rime-data-0.22.ebuild,v 1.3 2013/09/02 08:06:16 ago Exp $

EAPI=4

inherit vcs-snapshot
MY_P=brise-${PV}
DESCRIPTION="Data resources for Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="http://rimeime.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-i18n/librime"
RDEPEND="${DEPEND}"
S="${WORKDIR}"/${MY_P}

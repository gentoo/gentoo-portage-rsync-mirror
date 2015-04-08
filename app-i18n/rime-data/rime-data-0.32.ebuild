# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/rime-data/rime-data-0.32.ebuild,v 1.1 2014/01/11 01:10:00 dlan Exp $

EAPI=5

inherit vcs-snapshot
MY_P=brise-${PV}
DESCRIPTION="Data resources for Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="http://rimeime.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-i18n/librime"
RDEPEND="${DEPEND}"
S="${WORKDIR}"/${MY_P}

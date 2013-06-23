# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/partitionmanager/partitionmanager-1.0.3_p20130623.ebuild,v 1.1 2013/06/23 16:43:24 johu Exp $

EAPI=5

KMNAME="extragear/sysadmin"
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="KDE utility for management of partitions and file systems"
HOMEPAGE="http://partitionman.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~johu/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug"

RDEPEND="
	dev-libs/libatasmart
	>=sys-block/parted-3
	sys-apps/util-linux
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_configure() {
	mycmakeargs=(
		-DENABLE_UDISKS2=ON
	)

	kde4-base_src_configure
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs-headers/aufs-headers-3.8.0.ebuild,v 1.1 2013/03/10 10:39:53 jlec Exp $

EAPI=5

inherit versionator

DESCRIPTION="User space headers for aufs3"
HOMEPAGE="http://aufs.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

src_install() {
	sed -e "s:3.x-rcN:$(get_version_component_range 1-2):g" -i include/linux/aufs_type.h || die
	insinto /usr
	doins -r include
}

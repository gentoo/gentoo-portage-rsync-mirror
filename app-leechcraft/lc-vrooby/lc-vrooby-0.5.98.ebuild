# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-vrooby/lc-vrooby-0.5.98.ebuild,v 1.1 2013/07/03 16:21:15 maksbotan Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Vrooby, removable device manager for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug udisks udisks2"

DEPEND="~app-leechcraft/lc-core-${PV}
		dev-qt/qtdbus:4"
RDEPEND="${DEPEND}
		udisks? ( sys-fs/udisks:0 )
		udisks2? ( sys-fs/udisks:2 )
		"

REQUIRED_USE="|| ( udisks udisks2 )"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable udisks VROOBY_UDISKS)
		$(cmake-utils_use_enable udisks2 VROOBY_UDISKS2)
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	if use udisks2; then
		elog "You have enabled the experimental UDisks2 backend. "
		elog "Please try the old udisks:0-based one before "
		elog "reporting issues."
	fi
}

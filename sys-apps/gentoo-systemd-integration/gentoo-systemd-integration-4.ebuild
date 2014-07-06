# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gentoo-systemd-integration/gentoo-systemd-integration-4.ebuild,v 1.7 2014/07/06 13:23:06 mgorny Exp $

EAPI=5

inherit autotools-utils systemd

DESCRIPTION="systemd integration files for Gentoo"
HOMEPAGE="https://bitbucket.org/mgorny/gentoo-systemd-integration"
SRC_URI="https://www.bitbucket.org/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="!sys-fs/udev"
RDEPEND="${DEPEND}
	>=sys-apps/systemd-207"

src_configure() {
	local myeconfargs=(
		"$(systemd_with_unitdir)"
		# TODO: solve it better in the eclass
		--with-systemdsystemgeneratordir="$(systemd_get_utildir)"/system-generators
	)

	autotools-utils_src_configure
}

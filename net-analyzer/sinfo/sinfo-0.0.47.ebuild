# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sinfo/sinfo-0.0.47.ebuild,v 1.2 2012/10/08 20:21:44 radhermit Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="A monitoring tool for networked computers"
HOMEPAGE="http://www.ant.uni-bremen.de/whomes/rinas/sinfo/"
SRC_URI="http://www.ant.uni-bremen.de/whomes/rinas/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 static-libs"

RDEPEND="!sys-cluster/slurm
	dev-libs/boost
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog README )

src_configure() {
	local myeconfargs=(
		--with-ncurses
		$(use_enable ipv6 IPv6)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	newconfd "${FILESDIR}"/sinfod.confd sinfod
	newinitd "${FILESDIR}"/sinfod.initd sinfod
}

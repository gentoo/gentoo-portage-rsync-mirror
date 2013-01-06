# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/procenv/procenv-0.16.ebuild,v 1.1 2012/12/03 03:20:33 radhermit Exp $

EAPI="5"

DESCRIPTION="A command-line utility that simply dumps all attributes of its environment"
HOMEPAGE="https://launchpad.net/procenv/"
SRC_URI="https://launchpad.net/${PN}/trunk/v${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	default
	doman man/${PN}.1
}

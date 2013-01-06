# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sshpass/sshpass-1.05.ebuild,v 1.3 2011/09/18 21:48:33 maekke Exp $

EAPI="4"

DESCRIPTION="Tool for noninteractively performing password authentication with ssh."
HOMEPAGE="http://sshpass.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-misc/openssh"
DEPEND=""

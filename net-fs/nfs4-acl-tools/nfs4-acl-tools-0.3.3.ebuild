# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/nfs4-acl-tools/nfs4-acl-tools-0.3.3.ebuild,v 1.3 2011/09/07 10:51:29 scarabeus Exp $

EAPI=4

DESCRIPTION="Commandline and GUI tools that deal directly with NFSv4 ACLs"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/attr"

src_compile() {
	# not gnumakefile :/
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README TODO VERSION
}

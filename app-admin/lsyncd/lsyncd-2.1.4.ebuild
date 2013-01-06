# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lsyncd/lsyncd-2.1.4.ebuild,v 1.2 2012/12/02 00:38:55 radhermit Exp $

EAPI=5

DESCRIPTION="Live Syncing (Mirror) Daemon"
HOMEPAGE="http://code.google.com/p/lsyncd/"
SRC_URI="http://lsyncd.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

CDEPEND=">=dev-lang/lua-5.1[deprecated]"
DEPEND="${CDEPEND}
	app-text/asciidoc"
RDEPEND="${CDEPEND}
	net-misc/rsync"

src_configure() {
	econf --docdir="${EPREFIX}"/usr/share/doc/${P}
}

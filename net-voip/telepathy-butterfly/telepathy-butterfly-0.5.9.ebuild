# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-butterfly/telepathy-butterfly-0.5.9.ebuild,v 1.7 2010/08/07 16:52:12 armin76 Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"

inherit python multilib eutils

DESCRIPTION="An MSN connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/releases/telepathy-butterfly/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-python/telepathy-python-0.15.17
	>=dev-python/papyon-0.4.2"

DOCS="AUTHORS NEWS"

src_prepare() {
	#Disabled because it crashes against 0.2.3 that is in the tree
	#When a newer version is added, we have to force a dep on it
	#like this and remove this patch
	# libproxy? ( >=net-libs/libproxy-0.3.1 )
	# !<net-libs/libproxy-0.3
	epatch "${FILESDIR}"/telepathy-butterfly-0.5.9-Disable-libproxy-support.patch
}

src_install() {
	make install DESTDIR="${D}"
}

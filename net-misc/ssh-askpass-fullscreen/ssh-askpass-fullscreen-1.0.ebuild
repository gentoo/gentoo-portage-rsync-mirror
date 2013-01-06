# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ssh-askpass-fullscreen/ssh-askpass-fullscreen-1.0.ebuild,v 1.2 2012/10/12 21:41:03 tetromino Exp $

EAPI=4

DESCRIPTION="A small SSH Askpass replacement written with GTK2"
HOMEPAGE="https://github.com/atj/ssh-askpass-fullscreen"
SRC_URI="https://github.com/downloads/atj/${PN}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10.0:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

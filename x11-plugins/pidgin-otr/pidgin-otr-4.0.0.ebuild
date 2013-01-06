# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-otr/pidgin-otr-4.0.0.ebuild,v 1.1 2012/10/18 16:16:42 kensington Exp $

EAPI=4

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/libgcrypt
	net-im/pidgin[gtk]
	>=net-libs/libotr-4.0.0
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

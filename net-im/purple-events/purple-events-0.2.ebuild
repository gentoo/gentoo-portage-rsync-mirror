# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/purple-events/purple-events-0.2.ebuild,v 1.3 2012/12/04 15:41:14 ago Exp $

EAPI=4

DESCRIPTION="Allows a fine-grained control over libpurple events"
HOMEPAGE="http://purple-events.sardemff7.net/"
SRC_URI="mirror://github/sardemff7/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-im/pidgin"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

src_configure() {
	econf --disable-silent-rules
}

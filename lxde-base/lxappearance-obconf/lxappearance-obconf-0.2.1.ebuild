# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxappearance-obconf/lxappearance-obconf-0.2.1.ebuild,v 1.2 2014/02/14 19:14:39 maekke Exp $

EAPI=5

DESCRIPTION="LXAppearance plugin for configuring OpenBox"
HOMEPAGE="http://lxde.sourceforge.net"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="lxde-base/lxappearance
	x11-wm/openbox"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool "

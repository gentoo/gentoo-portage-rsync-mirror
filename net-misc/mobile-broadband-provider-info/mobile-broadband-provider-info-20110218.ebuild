# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mobile-broadband-provider-info/mobile-broadband-provider-info-20110218.ebuild,v 1.2 2011/03/18 15:46:48 mr_bones_ Exp $

inherit gnome.org

DESCRIPTION="Database of mobile broadband service providers"
HOMEPAGE="http://live.gnome.org/NetworkManager/MobileBroadband/ServiceProviders"

LICENSE="CC-PD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README || die "dodoc failed"
}

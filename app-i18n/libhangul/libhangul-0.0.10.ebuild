# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libhangul/libhangul-0.0.10.ebuild,v 1.6 2011/09/25 17:54:59 armin76 Exp $

DESCRIPTION="libhangul is a generalized and portable library for processing hangul."
HOMEPAGE="http://kldp.net/projects/hangul/"
SRC_URI="http://kldp.net/frs/download.php/5417/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README
}

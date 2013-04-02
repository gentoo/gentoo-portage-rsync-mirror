# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/validns/validns-0.6.ebuild,v 1.2 2013/04/02 08:27:33 pinkbyte Exp $

EAPI=4

inherit eutils

DESCRIPTION="A high performance DNS/DNSSEC zone validator"
HOMEPAGE="http://www.validns.net/"
SRC_URI="http://www.validns.net/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="test? ( dev-perl/Test-Command-Simple )"
RDEPEND="dev-libs/judy"

# tests are broken, bug #464170
RESTRICT="test"

src_install() {
	dobin validns
	doman validns.1
	dodoc {notes,technical-notes,todo,usage}.mdwn Changes README
}

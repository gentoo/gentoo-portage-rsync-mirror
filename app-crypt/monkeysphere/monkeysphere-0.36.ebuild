# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/monkeysphere/monkeysphere-0.36.ebuild,v 1.1 2013/11/12 07:17:45 patrick Exp $

EAPI=5

DESCRIPTION="Leverage the OpenPGP web of trust for OpenSSH and Web authentication"
HOMEPAGE="http://web.monkeysphere.info/"
SRC_URI="http://archive.${PN}.info/debian/pool/${PN}/${PN::1}/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test"
# tests do weird things with network and fail OOTB
RESTRICT="test"

RDEPEND="
	app-crypt/gnupg
	dev-perl/Crypt-OpenSSL-RSA
	dev-perl/Digest-SHA1
	test? ( net-misc/socat )
	"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i "s#share/doc/monkeysphere#share/doc/${PF}#" Makefile
}

DOCS=(README Changelog COPYING)

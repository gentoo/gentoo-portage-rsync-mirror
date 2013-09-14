# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sendxmpp/sendxmpp-1.23.ebuild,v 1.6 2013/09/14 10:02:13 ago Exp $

EAPI=5

inherit perl-module

DESCRIPTION="sendxmpp is a perl-script to send xmpp (jabber), similar to what mail(1) does for mail."
HOMEPAGE="http://sendxmpp.hostname.sk/"
SRC_URI="mirror://debian/pool/main/s/sendxmpp/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/Net-XMPP
	dev-perl/Authen-SASL
	virtual/perl-Getopt-Long"

S="${WORKDIR}"/lhost-${PN}-610082b

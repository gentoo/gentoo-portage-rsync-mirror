# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Pcap/Net-Pcap-0.160.0.ebuild,v 1.3 2012/03/25 16:09:31 armin76 Exp $

EAPI=4

MODULE_AUTHOR=SAPER
MODULE_VERSION=0.16
inherit perl-module eutils

DESCRIPTION="Perl Net::Pcap - Perl binding to the LBL pcap"

SLOT="0"
KEYWORDS="~alpha amd64 ppc x86"
IUSE=""

RDEPEND="net-libs/libpcap
	dev-perl/IO-Interface"
DEPEND="${RDEPEND}"

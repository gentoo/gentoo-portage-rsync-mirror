# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-PcapUtils/Net-PcapUtils-0.10.0.ebuild,v 1.3 2012/03/25 16:08:47 armin76 Exp $

EAPI=4

MODULE_AUTHOR=TIMPOTTER
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Perl Net::PcapUtils - Net::Pcap library utils"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-perl/Net-Pcap"
DEPEND="${RDEPEND}"

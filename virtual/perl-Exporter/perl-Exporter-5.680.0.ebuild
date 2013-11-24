# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Exporter/perl-Exporter-5.680.0.ebuild,v 1.2 2013/11/24 19:04:16 zlogene Exp $

DESCRIPTION="Virtual for perl-core/Exporter"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	|| (
		(
			>=dev-lang/perl-5.17.11
			<=dev-lang/perl-5.19.2
			!perl-core/Exporter
		)
		~perl-core/Exporter-${PV}
	)
"
